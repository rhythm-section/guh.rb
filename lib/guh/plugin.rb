module Guh
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
    #   Guh::Plugin.all
    #
    def self.all
      response = get({
        id: generate_request_id,
        method: "Devices.GetPlugins"
      })

      response['plugins']
    end

    ##
    #
    # Set some params on a plugin.
    #
    # Example:
    #
    #   HiveRpcWrapper::Plugin.set_params("TODO get proper plugin id", {foo: "bar"})
    #
    # def self.set_config(plugin_id, params)
    #   get({
    #     id: generate_request_id,
    #     method: "Devices.SetPluginConfig",
    #     params: {
    #       pluginId: plugin_id,
    #       params: params
    #     }
    #   })
    # end

  end
end
