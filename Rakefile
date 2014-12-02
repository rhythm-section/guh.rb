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

  Guh::Base.configure do |c|
    c.guh_ip_address = ENV['GUH_IP']
    c.guh_port = ENV['GUH_PORT']
  end

  ARGV.clear
  IRB.start
end
