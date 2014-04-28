require 'helper'

describe Guh::Device do
  
  it "should get the supported device" do
    response = Guh::Device.supported
    
    response.should be_an_instance_of(Array)
  end
  
  it "should get the configured device" do
    response = Guh::Device.configured
    
    response.should be_an_instance_of(Array)
  end
  
  it "should tell us the number of configured devices" do
    count = Guh::Device.count_configured
    
    count.should be_a(Integer)
  end
  
  it "should let us configure a device" do
    configured_count = Guh::Device.count_configured
    
    response = Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {
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
    
    Guh::Device.count_configured.should eq(configured_count+1)
  end
  
  it "should fail if we omit the params" do
    configured_count = Guh::Device.count_configured
    
    response = Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {})
    
    Guh::Device.count_configured.should eq(configured_count)
  end
  
end
