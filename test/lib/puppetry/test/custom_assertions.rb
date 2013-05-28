module MiniTest::Assertions
  def assert_contains_a_puppet_module(dir)
    assert Dir.exists?(dir), "Module folder #{dir} wasn't created"

    [ "manifests",
      "lib",
      "files",
      "templates",
      "tests" ].each do |subdir|
      Dir.entries(dir).must_include subdir
    end
  end

  def assert_bundler_is_initialized_in(dir)
    assert File.exists?(File.join(dir, "Gemfile")),
      "Expected #{dir} to have a Gemfile"

    assert Dir.exists?(File.join(dir, ".bundle")),
      "Expected Bundler to be initialized in folder #{dir}"
  end

  def assert_rspec_puppet_is_initialized_in(dir)
    module_name = File.basename(dir)

    assert Dir.exists?(File.join(dir, "spec")),
      "Expected directory #{dir} to contain directory 'spec'"

    assert File.exists?(File.join(dir, "spec", "spec_helper.rb")),
      "Expected directory 'spec' to include spec_helper file"

    %w{classes defines functions hosts fixtures unit}.each do |spec_component|
      assert Dir.exists?(File.join(dir, "spec", spec_component)),
        "Expected directory 'spec' to contain #{spec_component}"
    end

    assert File.exists?(File.join(dir, "spec", "fixtures", "manifests", "site.pp")),
      "Expected spec folder to contain fixtures/manifests/site.pp"

    module_image_dir = File.join(dir, "spec", "fixtures", "modules", module_name)

    assert Dir.exists?(module_image_dir),
      "Expected directory spec/fixtures/modules to contain subdirectory for current module"

    ["manifests", "lib", "files", "templates"].each do |module_component|
      assert Dir.exists?(File.join(module_image_dir, module_component)),
        "Expected directory #{module_image_dir} to contain directory #{module_component}"

      assert File.symlink?(File.join(module_image_dir, module_component)),
        "Expected directory #{File.join(module_image_dir, module_component)} to"\
        "be a symlink to its counterpart in the module's root"
    end
  end
end

module MiniTest::Expectations
  infect_an_assertion :assert_contains_a_puppet_module, :must_contain_a_puppet_module, :only_one_argument
end
