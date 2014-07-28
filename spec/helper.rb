require 'rubygems'
require 'rspec'

require 'guh'

TEST_HOME = File.expand_path('../tmp/test_home')

RSpec.configure do |config|

  config.before(:all) do
    Guh::Base.configure do |c|
      c.guh_ip_address = "127.0.0.1"
      c.guh_port = 1234
    end

    # Remove all devices & rules from Guh Core
    purge_configuration()

    start_guh()
    sleep(1)
  end

  config.after(:all) do
    stop_guh()
  end
end

def start_guh
  @guh_pipe = IO.popen("export HOME=#{TEST_HOME}; guh 2>&1")
end

def stop_guh
  Process.kill 'INT', @guh_pipe.pid
end

def purge_devices
  path = File.join(TEST_HOME, '.config/guh/guh.conf')
  File.unlink(path) if File.exist?(path)
end

def purge_rules
  path = File.join(TEST_HOME, '.config/guh/rules.conf')
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
  return Guh::Device.all.detect{|d| d['id']==device_id}
end
