require 'thor'
require 'fileutils'
require 'puppetry/version'
require 'bundler'
require 'systemu'

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
    def new(destination)
      FileUtils.mkdir destination
      module_folders.each do |dir|
        FileUtils.mkdir File.join(destination, dir)
      end

      File.open(File.join(destination, 'Gemfile'), 'w') do |gemfile|
        gemfile.write <<-EOF
          source "https://rubygems.org"

          gem "puppet"
          gem "rspec-puppet"
          gem "puppetlabs_spec_helper"
          gem "puppet-lint"
        EOF
      end

      FileUtils.cd destination do
        Bundler.with_clean_env do
          systemu "bundle install --path vendor/bundle", 'stdout' => output
        end

        FileUtils.mkdir_p rspec_puppet_folders

        File.open(File.join("spec", "spec_helper.rb"), 'w') do |spec_helper|
          spec_helper.write <<-EOF
            require 'puppetlabs_spec_helper/module_spec_helper'
          EOF
        end

        FileUtils.touch(File.absolute_path(File.join("spec", "fixtures", "manifests", "site.pp")))

        spec_module_dir = File.join("spec", "fixtures", "modules", File.basename(destination))
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

      def module_folders
        %w{manifests lib files templates tests}
      end

      def rspec_puppet_folders
        %w{ spec
            spec/classes
            spec/defines
            spec/functions
            spec/fixtures
            spec/fixtures/modules
            spec/fixtures/manifests
            spec/hosts
            spec/unit
          }
      end
    end
  end
end
