require 'test_helper'
require 'stringio'

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
      $stdout.string.must_match(/0.0.1/)
    end
  end
end
