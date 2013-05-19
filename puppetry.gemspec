$:.unshift 'lib'
require 'puppetry/version'

Gem::Specification.new do |s|
  s.name              = "puppetry"
  s.version           = Puppetry::Version
  s.summary           = "Puppetry is a CLI tool to aid Puppet modules development."
  s.homepage          = "https://github.com/stefanozanella/puppetry"
  s.email             = ["zanella.stefano@gmail.com"]
  s.authors           = ["Stefano Zanella"]

  s.files             = `git ls-files`.split($/)
  s.executables       = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files        = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths     = ["lib"]

  s.extra_rdoc_files  = ["README.md"]
  s.rdoc_options      = ["--charset=UTF-8"]

  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "grit"

  s.description = %s{
    Puppetry is a command line tool that aims at easing and uniforming
    development of Puppet modules, by performing common tasks such as setting
    up a new module source folder starting from a skeleton containing the
    proper directory structure and useful helpers.
  }
end
