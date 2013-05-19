require 'thor'

module Puppetry
  class CLI < Thor
    desc "version", "Print application's version"
    def version
      puts "Puppetry v#{Puppetry::Version}"
    end
  end
end
