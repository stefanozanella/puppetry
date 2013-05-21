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
    if no_tag_exists_for Puppetry::Version
      key = ENV['RUBYGEMS_API_KEY'] and setup_rubygems_credentials key
      Rake::Task["gem:release"].invoke 
      restore_rubygems_credentials if key
    end
  end
end

def no_tag_exists_for(version)
  `git tag`.split.grep(%r{v#{version}}).empty?
end

def setup_rubygems_credentials(key)
  Dir.mkdir gem_dir unless Dir.exists? gem_dir
  FileUtils.cp cred_file, "#{cred_file}.org" if File.exists? cred_file

  File.open cred_file, "w", 0600 do |creds|
    creds.puts "---"
    creds.puts ":rubygems_api_key: #{key}"
  end
end

def restore_rubygems_credentials
  FileUtils.rm cred_file
  FileUtils.mv "#{cred_file}.org", cred_file if File.exists? "#{cred_file}.org"
end

def gem_dir
  File.join(Dir.home, '.gem')
end

def cred_file
  File.join(gem_dir, 'credentials')
end
