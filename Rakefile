require "bundler/gem_tasks"
require "rspec/core/rake_task"

task "default" => "spec"

desc "Run all specs"
task "spec" => "spec:all"

namespace "spec" do
  task "all" => ["shinji", "dummy"]

  RSpec::Core::RakeTask.new("shinji") do |t|
    t.pattern = "spec/shinji/**/*_spec.rb"
  end

  task "dummy" do |t|
    system("cd spec/dummy && rake")
  end
end
