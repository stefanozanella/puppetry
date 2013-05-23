require 'test_helper'
require 'stringio'
require 'tmpdir'
require 'fileutils'

describe "puppetry" do
  let(:module_dir) { "test_module" }
  let(:out) { StringIO.new }
  let(:working_dir) { Dir.mktmpdir }
  let(:cli) { Puppetry::CLI.new }

  before do
    cli.output = out
  end

  after do
    FileUtils.remove_entry_secure working_dir
  end

  describe "version" do
    it "shows the application's version" do
      cli.version
      out.string.must_match(/#{Puppetry::VERSION}/)
    end
  end

  describe "new" do
    before do
      @old_pwd = FileUtils.pwd
      FileUtils.cd(working_dir)

      cli.new module_dir
    end

    after do
      FileUtils.cd @old_pwd
    end

    it "creates a new module starting from a scaffolded one" do
      module_dir.must_contain_a_puppet_module
      module_dir.wont_be_a_git_repository
      assert_bundler_is_initialized_in  module_dir
    end
  end
end
