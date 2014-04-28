require "bundler/gem_tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'pp'
  require 'guh'
  ARGV.clear
  IRB.start
end