module HiveRpcWrapper
  class Plugin < Base
    
    def all
      get({
        id: generate_request_id,
        method: "Devices.GetPlugins"
      })
    end
    
  end
end
