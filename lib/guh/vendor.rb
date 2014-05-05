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
    #   Guh::Vendor.all
    # 
    def self.all
      response = get({
        id: generate_request_id,
        method: "Devices.GetSupportedVendors"
      })
      
      return response['vendors']
    end
    
  end
end
