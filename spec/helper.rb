require 'rubygems'
require 'rspec'


require 'hive_rpc_wrapper'

puts "\n\n---------------------------------------------------"
puts "Please make sure that hive is running"
puts "---------------------------------------------------\n\n"


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
