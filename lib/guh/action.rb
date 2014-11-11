module Guh
  ##
  # This class wraps everything related to Actions.
  #
  class Action < Base

    ##
    #
    # Executes a specific Action on a specific Device.
    #
    # To activate an "Elro Power Switch":
    #
    #   Guh::Action.execute("TODO find specific device id", "{31c9758e-6567-4f89-85bb-29e1a7c55d44}", {power: true})
    #
    def self.execute(device_id, action_type_id, params={})
      response = get({
        id: generate_request_id,
        method: "Actions.ExecuteAction",
        params: {
          deviceId: device_id,
          actionTypeId: action_type_id,
          params: params
        }
      })

      if response['deviceError'] == 'DeviceErrorNoError'
        return response
      else
        raise Guh::DeviceError, response['deviceError']
      end
    end

  end
end
