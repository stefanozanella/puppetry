require 'thor'
require 'grit'
require 'fileutils'
require 'puppetry/version'
require 'bundler'

module Puppetry
  class CLI < Thor
    desc "version", "Print application's version"
    def version
      output.puts "Puppetry v#{Puppetry::Version}"
    end

    desc "new NAME", "Create a new module called NAME"
    def new(name)
      repo = Grit::Repo.init(name)
      repo.remote_add 'skeleton', 'https://github.com/stefanozanella/puppet-skeleton'
      FileUtils.cd name do
        # No support for push/pull in Grit?
        `git pull skeleton master`

        Bundler.with_clean_env do
          system "bundle install --path vendor/bundle"
        end
      end
    end
    
    no_commands do
      ##
      # Overrides the default output stream (`$stdout`) used by the
      # application. Useful for testing.
      #
      # param output [IO] An IO object that will receive the CLI standard
      # output
      def output=(output)
        @output = output
      end
  
      private

      def output
        @output || $stdout
      end
    end
  end
end
