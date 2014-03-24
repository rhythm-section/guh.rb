require 'rubygems'
require 'rspec'

require 'hive_rpc_wrapper'

puts "\n\n---------------------------------------------------"
puts "Please make sure that hive is running"
puts "---------------------------------------------------\n\n"

RSpec.configure do |config|
  config.before(:all) do
    HiveRpcWrapper::Base.configure do |c|
      c.hive_ip_address = "0.0.0.0"
      c.hive_port = 1234
    end
    
    # Remove all devices & rules from Hive Core
    purge_configuration()
  end
end

def purge_devices
  path = File.expand_path('~/.config/hiveyourhome/hive.conf')
  File.unlink(path) if File.exist?(path)
end

def purge_rules
  path = File.expand_path('~/.config/hiveyourhome/rules.conf')
  File.unlink(path) if File.exist?(path)
end

def purge_configuration
  purge_devices()
  purge_rules()
end

def pj(data)
  puts ""
  puts "-"*15
  puts data.inspect
  puts "-"*15
  puts ""
end
