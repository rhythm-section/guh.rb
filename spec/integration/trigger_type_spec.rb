require 'helper'

describe HiveRpcWrapper::TriggerType do
  
  it "should get something back" do
    device = HiveRpcWrapper::Device.supported['params']['deviceClasses'].first
    
    response = HiveRpcWrapper::TriggerType.all(device['id'])
    
    response['status'].should eq('success')
  end
  
end
