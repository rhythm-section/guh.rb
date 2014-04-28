require 'rubygems'
require 'rspec'

require 'guh'

puts "\n\n---------------------------------------------------"
puts "Please make sure that Guh is running"
puts "---------------------------------------------------\n\n"

RSpec.configure do |config|
  config.before(:all) do
    Guh::Base.configure do |c|
      c.guh_ip_address = "127.0.0.1"
      c.guh_port = 1234
    end
    
    # Remove all devices & rules from Guh Core
    purge_configuration()
  end
end

def purge_devices
  path = File.expand_path('~/.config/guh/guh.conf')
  File.unlink(path) if File.exist?(path)
end

def purge_rules
  path = File.expand_path('~/.config/guh/rules.conf')
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

def create_configured_device(device_class_id, params)
  # Create a device
  device_id = Guh::Device.add(device_class_id, params)
  
  # Get the newly configured device
  return Guh::Device.configured.detect{|d| d['id']==device_id}
end
