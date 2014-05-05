require 'helper'

describe Guh::DeviceClass do
  
  it "should get the supported devices" do
    response = Guh::DeviceClass.all
    
    response.should be_an_instance_of(Array)
  end
  
  it "should find a specific DeviceClass" do
    pending
  end
  
  it "should get the supported devices of a specific vendor" do
    response = Guh::Vendor.all
    
    vendor_id = response['vendors'].first['id']
    
    devices = Guh::DeviceClass.all(vendor_id: vendor_id)
    
    if devices.length > 0
      devices.first['vendorId'].should eq(vendor_id)
    end
  end
  
end
