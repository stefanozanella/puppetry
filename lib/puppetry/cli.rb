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

    desc "new DEST", "Create a new module in DEST"
    long_desc <<-EOS
      `puppetry new DEST` will initialize a new module in the DEST directory.

      The name of the module is calculated from the basename of DEST (i.e. the
      latest segment of the path), so all the following will create a module
      named `apache`:
      > puppetry new apache
      > puppetry new ~/code/puppet/apache
    EOS
    def new(name)
      repo = Grit::Repo.init(name)
      repo.remote_add 'skeleton', 'https://github.com/stefanozanella/puppet-skeleton'
      FileUtils.cd name do
        # No support for push/pull in Grit?
        `git pull skeleton master`

        Bundler.with_clean_env do
          system "bundle install --path vendor/bundle"
        end

        spec_module_dir = File.join("spec", "fixtures", "modules", File.basename(name))
        FileUtils.mkdir spec_module_dir
        FileUtils.cd spec_module_dir do
          ["manifests", "lib", "templates", "files"].each do |dir|
            File.symlink File.join(*Array.new(4, '..'), dir), dir
          end
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
