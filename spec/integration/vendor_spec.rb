require 'helper'

describe Guh::Vendor do
  
  it "should return a list of available vendors" do
    
    response = Guh::Vendor.all
    
    response['vendors'].length.should be > 0
    
  end
  
  it "should return information about a specific vendor" do
    pending "TODO: Implement Guh::Vendor.find('{abc}')"
  end
  
end