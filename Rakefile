require 'rake/testtask'
require 'puppetry/version'

namespace :gem do
  require 'bundler/gem_tasks'
end

namespace :test do
  Rake::TestTask.new(:end_to_end) do |t|
    t.verbose = true
    t.libs << "lib"
    t.libs << "test"
    t.test_files = FileList["test/end_to_end/**/*_test.rb"]
    #t.ruby_opts = ["-w"]
  end
end

namespace :ci do
  desc "Release a new gem version only if tag for current version doesn't exist yet"
  task :release do
    Rake::Task["gem:release"].invoke if `git tag`.split.grep(%r{v#{Puppetry::Version}}).empty?
  end
end
