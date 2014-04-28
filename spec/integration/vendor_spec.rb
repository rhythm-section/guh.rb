require 'helper'

describe Guh::Vendor do
  
  it "should return a list of available vendors" do
    
    response = Guh::Vendor.supported
    
    response['vendors'].length.should be > 0
    
  end
  
end