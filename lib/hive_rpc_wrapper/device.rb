module HiveRpcWrapper
  class Device < Base
    
    def self.configured
      get({
        id: generate_request_id,
        method: "Devices.GetConfiguredDevices"
      })
    end
    
    def self.supported
      get({
        id: generate_request_id,
        method: "Devices.GetSupportedDevices"
      })
    end
    
  end
end
