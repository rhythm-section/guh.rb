module Guh
  ##
  # This class wraps everything related to Vendors.
  #
  class Vendor < Base
    ##
    #
    # Retrieves a specific vendor
    #
    # Example:
    #
    #   Guh::Vendor.find('{b241f7f5-8153-4a72-b260-f62beadc2d19}')
    #
    def self.find(vendor_id)
      all.detect { |vendor| vendor['id'] == vendor_id }
    end

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
