module Guh
  ##
  # This class wraps everything related to Vendors.
  # 
  class Vendor < Base
    
    ##
    # 
    # Retrieves a list of all supported vendors
    # 
    # Example:
    # 
    #   Guh::Vendor.supported
    # 
    def self.supported
      get({
        id: generate_request_id,
        method: "Devices.GetSupportedVendors"
      })
    end
    
  end
end
