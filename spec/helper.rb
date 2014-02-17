require 'rubygems'
require 'rspec'

require 'hive_rpc_wrapper'

puts "\n\n---------------------------------------------------"
puts "Please make sure that hive is running"
puts "---------------------------------------------------\n\n"


def purge_devices
  File.expand_path('~/.config/hiveyourhome/hive.conf')
end

def purge_rules
  File.expand_path('~/.config/hiveyourhome/rules.conf')
end

def purge_configuration
  purge_devices()
  purge_rules()
end
