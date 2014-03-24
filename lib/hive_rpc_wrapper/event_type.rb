module HiveRpcWrapper
  ##
  # This class wraps everything related to EventTypes.
  # 
  class EventType < Base
    
    ##
    # 
    # Returns a list of all available EventTypes.
    # 
    # Example:
    # 
    #   HiveRpcWrapper::EventType.all(device_class_id)
    # 
    def self.all(device_class_id)
      response = get({
        id: generate_request_id,
        method: "Devices.GetEventTypes",
        params: {
          deviceClassId: device_class_id
        }
      })
      
      response['eventTypes']
    end
    
  end
end
