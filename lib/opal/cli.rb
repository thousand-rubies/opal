# frozen_string_literal: true

require 'opal/requires'
require 'opal/builder'
require 'opal/cli_runners'

module Opal
  class CLI
    attr_reader :options, :file, :compiler_options, :evals, :load_paths, :argv,
      :output, :requires, :rbrequires, :gems, :stubs, :verbose, :runner_options,
      :preload, :filename, :debug, :no_exit, :lib_only, :missing_require_severity,
      :no_cache

    class << self
      attr_accessor :stdout
    end

    def initialize(options = nil)
      options ||= {}

      # Runner
      @runner_type    = options.delete(:runner)         || :nodejs
      @runner_options = options.delete(:runner_options) || {}

      @options     = options
      @sexp        = options.delete(:sexp)
      @repl        = options.delete(:repl)
      @file        = options.delete(:file)
      @no_exit     = options.delete(:no_exit)
      @lib_only    = options.delete(:lib_only)
      @argv        = options.delete(:argv)       { [] }
      @evals       = options.delete(:evals)      { [] }
      @load_paths  = options.delete(:load_paths) { [] }
      @gems        = options.delete(:gems)       { [] }
      @stubs       = options.delete(:stubs)      { [] }
      @preload     = options.delete(:preload)    { [] }
      @output      = options.delete(:output)     { self.class.stdout || $stdout }
      @verbose     = options.delete(:verbose)    { false }
      @debug       = options.delete(:debug)      { false }
      @filename    = options.delete(:filename)   { @file && @file.path }
      @requires    = options.delete(:requires)   { [] }
      @rbrequires  = options.delete(:rbrequires) { [] }
      @no_cache    = options.delete(:no_cache)   { false }

      @debug_source_map = options.delete(:debug_source_map) { false }

      @missing_require_severity = options.delete(:missing_require_severity) { Opal::Config.missing_require_severity }

      @requires.unshift('opal') unless options.delete(:skip_opal_require)

      @compiler_options = compiler_option_names.map do |option|
        key = option.to_sym
        next unless options.key? key
        value = options.delete(key)
        [key, value]
      end.compact.to_h

      raise ArgumentError, 'no libraries to compile' if @lib_only && @requires.empty?
      raise ArgumentError, 'no runnable code provided (evals or file)' if @evals.empty? && @file.nil? && !@lib_only
      raise ArgumentError, "can't accept evals or file in `library only` mode" if (@evals.any? || @file) && @lib_only
      raise ArgumentError, "unknown options: #{options.inspect}" unless @options.empty?
    end

    def run
      return show_sexp if @sexp
      return debug_source_map if @debug_source_map
      return run_repl if @repl

      rbrequires.each { |file| require file }

      runner = self.runner

      # Some runners may need to use a dynamic builder, that is,
      # a builder that will try to build the entire package every time
      # a page is loaded - for example a Server runner that needs to
      # rerun if files are changed.
      builder = proc { create_builder }

      @exit_status = runner.call(
        options: runner_options,
        output: output,
        argv: argv,
        builder: builder,
      )
    end

    def runner
      CliRunners[@runner_type] ||
        raise(ArgumentError, "unknown runner: #{@runner_type.inspect}")
    end

    def run_repl
      require 'opal/repl'

      repl = REPL.new
      repl.run(OriginalARGV)
    end

    attr_reader :exit_status

    def create_builder
      builder = Opal::Builder.new(
        stubs: stubs,
        compiler_options: compiler_options,
        missing_require_severity: missing_require_severity,
      )

      # --no-cache
      builder.cache = Opal::Cache::NullCache.new if no_cache

      # --include
      builder.append_paths(*load_paths)

      # --gem
      gems.each { |gem_name| builder.use_gem gem_name }

      # --require
      requires.each { |required| builder.build(required, requirable: true, load: true) }

      # --preload
      preload.each { |path| builder.build_require(path) }

      # --verbose
      builder.build_str '$VERBOSE = true', '(flags)', no_export: true if verbose

      # --debug
      builder.build_str '$DEBUG = true', '(flags)', no_export: true if debug

      # --eval / stdin / file
      evals_or_file { |source, filename| builder.build_str(source, filename) }

      # --no-exit
      builder.build_str '::Kernel.exit', '(exit)', no_export: true unless no_exit

      builder
    end

    def show_sexp
      evals_or_file do |contents, filename|
        buffer = ::Opal::Parser::SourceBuffer.new(filename)
        buffer.source = contents
        sexp = Opal::Parser.default_parser.parse(buffer)
        output.puts sexp.inspect
      end
    end

    def debug_source_map
      evals_or_file do |contents, filename|
        compiler = Opal::Compiler.new(contents, file: filename, **compiler_options)

        compiler.compile

        result = compiler.result
        source_map = compiler.source_map.to_json

        b64 = [result, source_map, contents].map { |i| Base64.strict_encode64(i) }.join(',')

        output.puts "https://sokra.github.io/source-map-visualization/#base64,#{b64}"
      end
    end

    def compiler_option_names
      %w[
        method_missing
        arity_check
        dynamic_require_severity
        source_map_enabled
        irb_enabled
        inline_operators
        enable_source_location
        enable_file_source_embed
        use_strict
        parse_comments
        esm
      ]
    end

    # Internal: Yields a string of source code and the proper filename for either
    #           evals, stdin or a filepath.
    def evals_or_file
      # --library
      return if lib_only

      if evals.any?
        yield evals.join("\n"), '-e'
      elsif file && (filename != '-' || evals.empty?)
        file.rewind
        yield file.read, filename
      end
    end
  end
end
