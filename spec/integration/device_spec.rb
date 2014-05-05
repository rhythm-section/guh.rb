require 'helper'

describe Guh::Device do
  
  it "should get the configured device" do
    response = Guh::Device.all
    
    response.should be_an_instance_of(Array)
  end
  
  it "should tell us the number of configured devices" do
    count = Guh::Device.count
    
    count.should be_a(Integer)
  end
  
  it "should let us configure a device" do
    configured_count = Guh::Device.count
    
    -> {
      response = Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {
        channel1: true,
        channel2: false,
        channel3: false,
        channel4: false,
        channel5: false,
        channel6: false,
        channel7: false,
        channel8: false,
        channel9: false,
        channel10: false
      })
    }.should_not raise_error
    
    Guh::Device.count.should eq(configured_count+1)
  end
  
  it "should fail if we omit the params" do
    configured_count = Guh::Device.count
    
    -> {
      response = Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {})
    }.should raise_error
    
    Guh::Device.count.should eq(configured_count)
  end
  
  it "should create a new device, return its ID and remove it successfully" do
    device_id = Guh::Device.add("{ab73ad2f-6594-45a3-9063-8f72d365c5e5}", {familyCode: 'A'})
    
    device_id.should match(/^\{[a-z0-9\-]+\}$/i)
    
    Guh::Device.remove(device_id).should be_true
    
    Guh::Device.find(device_id).should be_nil
  end
  
  it "should raise an error if we try to delete a non-existing device" do
    -> {
      Guh::Device.remove("abc").should
    }.should raise_error
  end
  
end
