require 'helper'

describe Guh::DeviceClass do

  it "should get the supported devices" do
    response = Guh::DeviceClass.all

    response.should be_an_instance_of(Array)
  end

  it "should find a specific DeviceClass" do
    device_class_id = "{ab73ad2f-6594-45a3-9063-8f72d365c5e5}"

    -> {
      Guh::DeviceClass.find("bogus")
    }.should raise_error

    -> {
      device_class = Guh::DeviceClass.find(device_class_id)
      device_class['id'].should eq(device_class_id)
    }.should_not raise_error
  end

  it "should get the supported devices of a specific vendor" do
    response = Guh::Vendor.all

    vendor_id = response.first['id']

    devices = Guh::DeviceClass.all(vendor_id: vendor_id)

    if devices.length > 0
      devices.first['vendorId'].should eq(vendor_id)
    end
  end

  it "should discover the openweathermap" do

    device_class_id = "{985195aa-17ad-4530-88a4-cdd753d747d7}"

    pending "TODO wait until issue #13 is fixed"

    # device_descriptors = Guh::DeviceClass.discover(device_class_id, [
    #   {name: 'location', value: ''}
    # ])
    #
    # puts "--"
    # puts device_descriptors.inspect
    # puts "--"

  end

end
