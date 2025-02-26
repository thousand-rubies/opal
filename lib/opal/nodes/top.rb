# frozen_string_literal: true

require 'pathname'
require 'json'
require 'opal/version'
require 'opal/nodes/scope'

module Opal
  module Nodes
    # Generates code for an entire file, i.e. the base sexp
    class TopNode < ScopeNode
      handle :top

      children :body

      def compile
        compiler.top_scope = self
        compiler.dynamic_cache_result = true if sexp.meta[:dynamic_cache_result]

        push version_comment

        helper :return_val if compiler.eof_content

        if body == s(:nil)
          # A shortpath for empty (stub?) modules.
          if compiler.requirable? || compiler.esm? || compiler.eval?
            unshift 'Opal.return_val(Opal.nil); '
            definition
          else
            unshift 'Opal.nil; '
          end
        else
          in_scope do
            line '"use strict";' if compiler.use_strict?

            body_code = stmt(stmts)
            body_code = [body_code] unless body_code.is_a?(Array)

            if compiler.eval?
              add_temp '$nesting = self.$$is_a_module ? [self] : [self.$$class]' if @define_nesting
            else
              add_temp 'self = Opal.top' if @define_self
              add_temp '$nesting = []' if @define_nesting
            end
            add_temp '$$ = Opal.$r($nesting)' if @define_relative_access

            add_temp 'nil = Opal.nil'
            add_temp '$$$ = Opal.$$$' if @define_absolute_const

            add_used_helpers
            line scope.to_vars

            compile_method_stubs
            compile_irb_vars
            compile_end_construct

            line body_code
          end

          opening
          definition
          closing
        end

        add_file_source_embed if compiler.enable_file_source_embed?
      end

      def module_name
        Opal::Compiler.module_name(compiler.file).inspect
      end

      def definition
        if compiler.requirable?
          unshift "Opal.modules[#{module_name}] = "
        elsif compiler.esm? && !compiler.no_export?
          unshift 'export default '
        end
      end

      def opening
        async_prefix = "async " if await_encountered

        if compiler.requirable?
          unshift "#{async_prefix}function(Opal) {"
        elsif compiler.eval?
          unshift "(#{async_prefix}function(Opal, self) {"
        else
          unshift "Opal.queue(#{async_prefix}function(Opal) {"
        end
      end

      def closing
        if compiler.requirable?
          line "};\n"

          if compiler.load?
            # Opal.load normalizes the path, so that we can't
            # require absolute paths from CLI. For other cases
            # we can expect the module names to be normalized
            # already.
            line "Opal.load_normalized(#{module_name});"
          end
        elsif compiler.eval?
          line "})(Opal, self);"
        else
          line "});\n"
        end
      end

      def stmts
        compiler.returns(body)
      end

      # Returns '$$$', but also ensures that the '$$$' variable is set
      def absolute_const
        @define_absolute_const = true
        '$$$'
      end

      def compile_irb_vars
        if compiler.irb?
          line 'if (!Opal.irb_vars) { Opal.irb_vars = {}; }'
        end
      end

      def add_used_helpers
        compiler.helpers.to_a.each { |h| add_temp "$#{h} = Opal.#{h}" }
      end

      def compile_method_stubs
        if compiler.method_missing?
          calls = compiler.method_calls
          stubs = calls.to_a.map(&:to_s).join(',')
          line "Opal.add_stubs('#{stubs}');" unless stubs.empty?
        end
      end

      # Any special __END__ content in code
      def compile_end_construct
        if content = compiler.eof_content
          line 'var $__END__ = Opal.Object.$new();'
          line "$__END__.$read = $return_val(#{content.inspect});"
        end
      end

      def version_comment
        "/* Generated by Opal #{Opal::VERSION} */"
      end

      def add_file_source_embed
        filename = compiler.file
        source = compiler.source
        unshift "Opal.file_sources[#{filename.to_json}] = #{source.to_json};\n"
      end
    end
  end
end
