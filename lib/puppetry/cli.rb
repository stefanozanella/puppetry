require 'thor'
require 'grit'
require 'fileutils'
require 'puppetry/version'

module Puppetry
  class CLI < Thor
    desc "version", "Print application's version"
    def version
      puts "Puppetry v#{Puppetry::Version}"
    end

    desc "new NAME", "Create a new module called NAME"
    def new(name)
      Grit::Git.new(name).clone({}, "git://github.com/stefanozanella/puppet-skeleton", name)
      # This looks rather rough, but maybe it's the simplest way to erase all
      # git history from the folder?
      FileUtils.rm_rf File.expand_path('.git', name)
    end
  end
end
