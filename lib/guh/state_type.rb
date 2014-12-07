module Guh
  ##
  # This class wraps everything related to the state types of a device class.
  #
  class StateType < Base

    def self.all(device_class_id)
      response = get({
        id: generate_request_id,
        method: 'Devices.GetStateTypes',
        params: { deviceClassId: device_class_id }
      })
      return response['stateTypes']
    end

  end

end
