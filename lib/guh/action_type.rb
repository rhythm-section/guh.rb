module Guh
  ##
  # This class wraps everything related to ActionTypes.
  #
  class ActionType < Base

    ##
    # Retrieves all known ActionTypes for a specific Device identified by its +device_id+.
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

  end
end
