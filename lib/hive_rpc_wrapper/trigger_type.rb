module HiveRpcWrapper
  ##
  # This class wraps everything related to TriggerTypes.
  # 
  class TriggerType < Base
    
    ##
    # 
    # Returns a list of all available TriggerTypes.
    # 
    # Example:
    # 
    #   HiveRpcWrapper::TriggerType.all(device_class_id)
    # 
    def self.all(device_class_id)
      get({
        id: generate_request_id,
        method: "Devices.GetTriggerTypes",
        params: {
          deviceClassId: device_class_id
        }
      })
    end
    
  end
end
