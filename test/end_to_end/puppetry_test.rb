require 'test_helper'
require 'stringio'
require 'tmpdir'
require 'fileutils'

describe "puppetry" do
  before do
    @orig_stdout = $stdout
    $stdout = StringIO.new
  end

  after do
    $stdout = @orig_stdout
  end

  describe "version" do
    it "shows the application's version" do
      Puppetry::CLI.start(["version"])
      $stdout.string.must_match(/#{Puppetry::VERSION}/)
    end
  end

  describe "new" do
    it "creates a new module starting from a scaffolded one" do
      Dir.mktmpdir do |dir|
        FileUtils.cd(dir) do
          Puppetry::CLI.start(["new", "test_module"])

          # test_module should exist and not be empty
          assert Dir.exists?("test_module"), "Module folder test_module wasn't created"
          Dir.entries("test_module").wont_be_empty
          # test_module should contain at least the manifests folder
          Dir.entries("test_module").must_include "manifests"
          # test_module should not be a git repo (for the moment)
          Dir.entries("test_module").wont_include ".git"
        end
      end
    end

    it "runs bundler to install deps after folder initialization" do
      Dir.mktmpdir do |dir|
        FileUtils.cd(dir) do
          Puppetry::CLI.start(["new", "test_module_setup"])

          assert Dir.entries("test_module_setup").must_include ".bundle"
        end
      end
    end
  end
end
