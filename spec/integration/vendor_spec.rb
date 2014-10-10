require 'helper'

describe Guh::Vendor do

  it "should return a list of available vendors" do

    response = Guh::Vendor.all

    response.length.should be > 0

  end

  it "should return information about a specific vendor" do
    vendor_id = '{b241f7f5-8153-4a72-b260-f62beadc2d19}'

    vendor = Guh::Vendor.find(vendor_id)

    vendor['id'].should eq(vendor_id)
  end

end
