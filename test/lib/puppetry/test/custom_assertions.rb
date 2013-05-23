module MiniTest::Assertions
  def assert_contains_a_puppet_module(dir)
    assert Dir.exists?(dir), "Module folder #{dir} wasn't created"
    Dir.entries(dir).wont_be_empty
    Dir.entries(dir).must_include "manifests"
  end 

  def refute_git_repository(dir)
    Dir.entries(dir).wont_include ".git"
  end

  def assert_bundler_is_initialized_in(dir)
    assert Dir.entries(dir).include?(".bundle"), "Bundler hasn't been initialized in folder #{dir}"
  end
end

module MiniTest::Expectations
  infect_an_assertion :assert_contains_a_puppet_module, :must_contain_a_puppet_module, :only_one_argument
  infect_an_assertion :refute_git_repository, :wont_be_a_git_repository, :only_one_argument
end
