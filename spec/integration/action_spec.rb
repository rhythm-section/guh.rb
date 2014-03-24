require 'helper'

describe HiveRpcWrapper::Action do
  
  before :all do
    # Elro Switch
    device_class_id = "{308ae6e6-38b3-4b3a-a513-3199da2764f8}"
    
    @device = create_configured_device(device_class_id, {
      channel1: true,
      channel2: false,
      channel3: false,
      channel4: false,
      channel5: false,
      A: true,
      B: false,
      C: false,
      D: false,
      E: false
    })
    
    # Get all the possible actions for the device
    response = HiveRpcWrapper::ActionType.all(device_class_id)
    
    response['status'].should eq('success')
    
    # Just use the first action
    @action = response['params']['actionTypes'].first
  end
  
  it "should execute a single action" do
    response = HiveRpcWrapper::Action.execute(@device['id'], @action['id'], {power: true})
    
    response['params']['success'].should be_true
  end
  
  it 'should fail if the wrong params are provided' do
    # response = HiveRpcWrapper::Action.execute(@device['id'], @action['id'], {})
    
    # response['params']['success'].should be_false
    pending("Don't run this test until we know if the params are optional")
  end
  
end
