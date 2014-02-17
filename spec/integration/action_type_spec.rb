require 'helper'

describe HiveRpcWrapper::ActionType do
  
  it "should return the supported actions for a device" do
    response = HiveRpcWrapper::ActionType.all("{308ae6e6-38b3-4b3a-a513-3199da2764f8}")
    
    response['params']['success'].should be_true
  end
  
end
