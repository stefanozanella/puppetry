require 'grit'

module MiniTest::Assertions
  def assert_contains_a_puppet_module(dir)
    assert Dir.exists?(dir), "Module folder #{dir} wasn't created"
    Dir.entries(dir).wont_be_empty
    Dir.entries(dir).must_include "manifests"
  end 

  def assert_is_git_repository(dir)
    assert Dir.entries(dir).include?(".git"), "Expected directory #{dir} to be a git repository"
  end

  def assert_tracks_remote(dir, remote)
    assert Grit::Repo.new(dir).git.remote.split.include?(remote), "Expected repo #{dir} to track remote #{remote}"
  end

  def assert_bundler_is_initialized_in(dir)
    assert Dir.entries(dir).include?(".bundle"), "Expected Bundler to be initialized in folder #{dir}"
  end
end

module MiniTest::Expectations
  infect_an_assertion :assert_contains_a_puppet_module, :must_contain_a_puppet_module, :only_one_argument
  infect_an_assertion :assert_is_git_repository, :must_be_a_git_repository, :only_one_argument
  infect_an_assertion :assert_tracks_remote, :must_track_remote, :do_not_flip
end
