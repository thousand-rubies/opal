# frozen_string_literal: true

require 'shellwords'
require 'socket'
require 'timeout'
require 'tmpdir'
require 'rbconfig'

module Opal
  module CliRunners
    class Chrome
      SCRIPT_PATH = File.expand_path('chrome_cdp_interface.rb', __dir__).freeze

      DEFAULT_CHROME_HOST = 'localhost'
      DEFAULT_CHROME_PORT = 9222

      def self.call(data)
        runner = new(data)
        runner.run
      end

      def initialize(data)
        builder = data[:builder].call
        options = data[:options]
        argv    = data[:argv]

        if argv && argv.any?
          warn "warning: ARGV is not supported by the Chrome runner #{argv.inspect}"
        end

        @output = options.fetch(:output, $stdout)
        @builder = builder
      end

      attr_reader :output, :exit_status, :builder

      def run
        mktmpdir do |dir|
          with_chrome_server do
            prepare_files_in(dir)

            env = {
              'CHROME_HOST' => chrome_host,
              'CHROME_PORT' => chrome_port.to_s,
              'NODE_PATH' => File.join(__dir__, 'node_modules')
            }

            cmd = [
              RbConfig.ruby,
              "#{__dir__}/../../../exe/opal",
              '--no-exit',
              '-I', __dir__,
              '-r', 'source-map-support-node',
              SCRIPT_PATH,
              dir,
            ]

            Kernel.exec(env, *cmd)
          end
        end
      end

      private

      def prepare_files_in(dir)
        js = builder.to_s
        map = builder.source_map.to_json
        stack = File.read("#{__dir__}/source-map-support-browser.js")

        ext = builder.output_extension
        module_type = ' type="module"' if builder.esm?

        # Chrome can't handle huge data passed to `addScriptToEvaluateOnLoad`
        # https://groups.google.com/a/chromium.org/forum/#!topic/chromium-discuss/U5qyeX_ydBo
        # The only way is to create temporary files and pass them to chrome.
        File.write("#{dir}/index.#{ext}", js)
        File.write("#{dir}/source-map-support.js", stack)
        File.write("#{dir}/index.html", <<~HTML)
          <html><head>
            <meta charset='utf-8'>
            <script src='./source-map-support.js'></script>
            <script>
            window.opalheadlesschrome = true;
            sourceMapSupport.install({
              retrieveSourceMap: function(path) {
                return path.endsWith('/index.#{ext}') ? {
                  url: './index.map', map: #{map.to_json}
                } : null;
              }
            });
            </script>
          </head><body>
            <script src='./index.#{ext}'#{module_type}></script>
          </body></html>
        HTML
      end

      def chrome_host
        ENV['CHROME_HOST'] || DEFAULT_CHROME_HOST
      end

      def chrome_port
        ENV['CHROME_PORT'] || DEFAULT_CHROME_PORT
      end

      def with_chrome_server
        if chrome_server_running?
          yield
        else
          run_chrome_server { yield }
        end
      end

      def run_chrome_server
        raise 'Chrome server can be started only on localhost' if chrome_host != DEFAULT_CHROME_HOST

        # Disable web security with "--disable-web-security" flag to be able to do XMLHttpRequest (see test_openuri.rb)
        chrome_server_cmd = %{#{windows? ? "\"#{chrome_executable.shellescape}\"" : chrome_executable.shellescape} \
          --headless \
          --disable-web-security \
          --remote-debugging-port=#{chrome_port} \
          #{ENV['CHROME_OPTS']}}

        chrome_pid = Process.spawn(chrome_server_cmd)

        Timeout.timeout(10) do
          loop do
            break if chrome_server_running?
            sleep 0.5
          end
        end

        yield
      rescue Timeout::Error
        puts 'Failed to start chrome server'
        puts 'Make sure that you have it installed and that its version is > 59'
        exit(1)
      ensure
        if windows? && chrome_pid
          Process.kill('KILL', chrome_pid) unless system("taskkill /f /t /pid #{chrome_pid} >NUL 2>NUL")
        elsif chrome_pid
          Process.kill('HUP', chrome_pid)
        end
      end

      def chrome_server_running?
        puts "Connecting to #{chrome_host}:#{chrome_port}..."
        TCPSocket.new(chrome_host, chrome_port).close
        true
      rescue Errno::ECONNREFUSED, Errno::EADDRNOTAVAIL
        false
      end

      def chrome_executable
        ENV['GOOGLE_CHROME_BINARY'] ||
          if windows?
            [
              'C:/Program Files/Google/Chrome Dev/Application/chrome.exe',
              'C:/Program Files/Google/Chrome/Application/chrome.exe'
            ].each do |path|
              next unless File.exist? path
              return path
            end
          elsif mac_os?
            '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
          else
            %w[
              google-chrome-stable
              chromium
              chromium-freeworld
              chromium-browser
            ].each do |name|
              next unless system('sh', '-c', "command -v #{name.shellescape}", out: '/dev/null')
              return name
            end
            raise 'Cannot find chrome executable'
          end
      end

      def windows?
        /bccwin|cygwin|djgpp|mingw|mswin|wince/.match?(RbConfig::CONFIG['host_os'])
      end

      def mac_os?
        /darwin|mac os/.match?(RbConfig::CONFIG['host_os'])
      end

      def mktmpdir(&block)
        Dir.mktmpdir('chrome-opal-', &block)
      end
    end
  end
end
