require 'helper'

describe HiveRpcWrapper::TriggerType do
  
  before :all do
    HiveRpcWrapper::Base.configure do |c|
      c.hive_ip_address = "0.0.0.0"
      c.hive_port = 1234
    end
    
    # Remove all devices & rules from Hive Core
    purge_configuration()
  end
  
  it "should get something back" do
    device = HiveRpcWrapper::Device.supported['params']['deviceClasses'].first
    
    response = HiveRpcWrapper::TriggerType.all(device['id'])
    
    response['status'].should eq('success')
  end
  
end
