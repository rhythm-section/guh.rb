module HiveRpcWrapper
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
    #   HiveRpcWrapper::Device.configured
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
    #   HiveRpcWrapper::Device.supported
    # 
    def self.supported
      response = get({
        id: generate_request_id,
        method: "Devices.GetSupportedDevices"
      })
      
      return response['deviceClasses']
    end
    
    ##
    # 
    # Returns a list of all supported Devices.
    # 
    # Example for the "Elro Power Switch":
    # 
    #   HiveRpcWrapper::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {
    #     channel1: true,
    #     channel2: false,
    #     channel3: false,
    #     channel4: false,
    #     channel5: false,
    #     A: true,
    #     B: false,
    #     C: false,
    #     D: false,
    #     E: false
    #   })
    # 
    def self.add(device_class_id, params)
      get({
        id: generate_request_id,
        method: "Devices.AddConfiguredDevice",
        params: {
          deviceClassId: device_class_id,
          deviceParams: params
        }
      })
    end
    
    ##
    # 
    # Removes a configured device.
    # 
    # Example: HiveRpcWrapper::Device.add("TODO find proper device_id")
    # 
    def self.remove(device_id)
      
    end
    
    ##
    # 
    # Returns current number of configured devices
    # 
    # Example: HiveRpcWrapper::Device.count_configured
    # 
    def self.count_configured
      self.configured.length
    end
    
  end
end
