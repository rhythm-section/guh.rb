module HiveRpcWrapper
  class Device < Base
    
    def configured
      get({
        id: generate_request_id,
        method: "Devices.GetConfiguredDevices"
      })
    end
    
    def supported
      get({
        id: generate_request_id,
        method: "Devices.GetSupportedDevices"
      })
    end
    
  end
end
