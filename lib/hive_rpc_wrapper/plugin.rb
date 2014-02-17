module HiveRpcWrapper
  ##
  # This class wraps everything related to Plugins.
  # 
  class Plugin < Base
    
    ##
    # 
    # Returns a list of all installed plugins.
    # 
    # Example:
    # 
    #   HiveRpcWrapper::Plugin.all
    # 
    def self.all
      get({
        id: generate_request_id,
        method: "Devices.GetPlugins"
      })
    end
    
  end
end
