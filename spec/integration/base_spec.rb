require 'helper'

describe HiveRpcWrapper::Device do
  
  it 'should raise an exception if Hive Core is not running' do
    HiveRpcWrapper::Base.configure do |c|
      c.hive_ip_address = "0.0.0.0"
      c.hive_port = 7890 # <---- wrong port to provoke excpetion
    end
    
    expect { HiveRpcWrapper::Base.introspect }.to raise_error(Errno::ECONNREFUSED)
  end
  
  it 'should raise an exception if Hive Core does not respond with success on connect' do
    pending("TODO: Find a way to provoke this.")
  end
  
end