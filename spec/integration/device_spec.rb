require 'helper'

describe HiveRpcWrapper::Device do
  
  it "should get the supported device" do
    response = HiveRpcWrapper::Device.supported
    
    response['status'].should eq('success')
  end
  
  it "should get the configured device" do
    response = HiveRpcWrapper::Device.configured
    
    response['status'].should eq('success')
  end
  
  it "should tell us the number of configured devices" do
    count = HiveRpcWrapper::Device.count_configured
    
    count.should be_a(Integer)
  end
  
  it "should let us configure a device" do
    configured_count = HiveRpcWrapper::Device.count_configured
    
    response = HiveRpcWrapper::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {
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
    
    response['status'].should eq('success')
    
    HiveRpcWrapper::Device.count_configured.should eq(configured_count+1)
  end
  
end
