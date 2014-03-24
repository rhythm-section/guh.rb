require 'helper'

describe HiveRpcWrapper::EventType do
  
  it "should get something back" do
    # Elro Switch
    device_class_id = "{308ae6e6-38b3-4b3a-a513-3199da2764f8}"
    
    # Get all the possible events for the device
    response = HiveRpcWrapper::EventType.all(device_class_id)
    
    response['status'].should eq('success')
    
    pending "Right now we get empty responses for all events"
  end
  
end
