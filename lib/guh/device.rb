module Guh
  ##
  # This class wraps everything related to Devices.
  #
  class Device < Base
    
    ##
    # 
    # Returns a list of all configured Devices.
    # 
    # Example:
    # 
    #   Guh::Device.configured
    # 
    def self.configured
      response = get({
        id: generate_request_id,
        method: "Devices.GetConfiguredDevices"
      })
      
      return response['devices']
    end
    
    ##
    # 
    # Returns a list of all supported Devices.
    # 
    # Example:
    # 
    #   Guh::Device.supported
    #   # => a list of all supported devices
    # 
    #   Guh::Device.supported("{2062d64d-3232-433c-88bc-0d33c0ba2ba6}")
    #   # => a list of all supported devices of a specific vendor
    # 
    def self.supported(options={})
      params = {}
      params['vendorId'] = options['vendor_id'] unless options['vendor_id'].nil?
      
      response = get({
        id: generate_request_id,
        method: "Devices.GetSupportedDevices",
        params: params
      })
      
      return response['deviceClasses']
    end
    
    ##
    # 
    # Creates a configured device and returns it's ID.
    # 
    # Example for the "Elro Power Switch":
    # 
    #   Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {
    #     channel1: true,
    #     channel2: false,
    #     channel3: false,
    #     channel4: false,
    #     channel5: false,
    #     channel6: true,
    #     channel7: false,
    #     channel8: false,
    #     channel9: false,
    #     channel10: false
    #   })
    # 
    def self.add(device_class_id, params)
      response = get({
        id: generate_request_id,
        method: "Devices.AddConfiguredDevice",
        params: {
          deviceClassId: device_class_id,
          deviceParams: params
        }
      })
      if response['success']==true
        return response['deviceId']
      else
        raise Guh::ArgumentError, response['errorMessage']
      end
    end
    
    ##
    # 
    # Removes a configured device.
    # 
    # Example: Guh::Device.add("TODO find proper device_id")
    # 
    def self.remove(device_id)
      
    end
    
    ##
    # 
    # Returns current number of configured devices
    # 
    # Example: Guh::Device.count_configured
    # 
    def self.count_configured
      self.configured.length
    end
    
  end
end
