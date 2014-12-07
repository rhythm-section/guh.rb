module Guh
  ##
  # This class wraps everything related to Actions.
  #
  class Action < Base

    ##
    #
    # Example:
    #   Guh::ActionType.find("{cfbc6504-d86f-4856-8dfa-97b6fbb385e4}")
    #
    def self.find(action_type_id)
      response = get({
        id: generate_request_id,
        method: "Actions.GetActionType",
        params: {
          actionTypeId: action_type_id
        }
      })

      response['actionType']
    end

    ##
    # Retrieves all known ActionTypes for a specific Device identified by its +device_class_id+.
    #
    # Example:
    #
    #   Guh::ActionType.all("{308ae6e6-38b3-4b3a-a513-3199da2764f8}")
    #
    def self.all(device_class_id)
      response = get({
        id: generate_request_id,
        method: "Devices.GetActionTypes",
        params: {
          deviceClassId: device_class_id
        }
      })

      response['actionTypes']
    end

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
