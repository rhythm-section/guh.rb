module Guh
  ##
  # This class wraps everything related to configured Devices.
  #
  class Device < Base


    ##
    #
    def self.find(id)
      device = self.all.detect{|d| d['id']==id}

      return device
    end

    ##
    #
    # Returns a list of all configured Devices.
    #
    # Example:
    #
    #   Guh::Device.all
    #
    def self.all
      response = get({
        id: generate_request_id,
        method: "Devices.GetConfiguredDevices"
      })

      return response['devices']
    end

    ##
    #
    # Creates a configured device and returns it's ID.
    #
    # Example for the "Elro Power Switch":
    #
    #   Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", {
    #     channel1: true,
    #     channel2: false,
    #     channel3: false,
    #     channel4: false,
    #     channel5: false,
    #     channel6: true,
    #     channel7: false,
    #     channel8: false,
    #     channel9: false,
    #     channel10: false
    #   })
    #
    def self.add(device_class_id, params)
      response = get({
        id: generate_request_id,
        method: "Devices.AddConfiguredDevice",
        params: {
          deviceClassId: device_class_id,
          deviceParams: params
        }
      })
      if response['success']==true
        return response['deviceId']
      else
        raise Guh::ArgumentError, response['errorMessage']
      end
    end

    ##
    #
    # Removes a configured device.
    #
    # Example:
    #
    #   device_id = Guh::Device.add("{ab73ad2f-6594-45a3-9063-8f72d365c5e5}", {familyCode: 'A'})
    #
    #   Guh::Device.remove(device_id)
    #
    def self.remove(device_id)
      response = get({
        id: generate_request_id,
        method: "Devices.RemoveConfiguredDevice",
        params: {
          deviceId: device_id
        }
      })
      if response['success']==true
        return true
      else
        raise Guh::ResponseError, response['errorMessage']
      end
    end

    ##
    #
    # Returns current number of configured devices
    #
    # Example: Guh::Device.count_configured
    #
    def self.count
      self.all.length
    end

  end
end
