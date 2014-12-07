module Guh
  ##
  # This class wraps everything related to the state of a device.
  #
  class State < Base

    def self.find(device_id, state_id)
      get({
        id: generate_request_id,
        method: 'Devices.GetStateValue',
        params: {
          deviceId: device_id,
          stateTypeId: state_id
        }
      })
    end

    def self.all(device_id)
      device = Guh::Device.find(device_id)
      state_types = Guh::StateType.all(device['deviceClassId'])

      values = []
      state_types.each do |state|
        value = state
        value['value'] = Guh::State.find(device_id, state['id'])

        values << value
      end

      return values
    end

  end

end
