module HiveRpcWrapper
  class TriggerType < Base
    
    def self.all
      get({
        id: generate_request_id,
        method: "Devices.GetTriggerTypes",
        params: {
          deviceClassId: "bogus"
        }
      })
    end
    
  end
end
