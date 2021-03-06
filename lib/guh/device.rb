module Guh
  ##
  # This class wraps everything related to configured Devices.
  #
  # TODO write up the creation of a normal device
  #
  # TODO write up the creation of a discoverable device.
  #
  class Device < Base


    ##
    #
    # Returns a specific configured Device.
    #
    # Example:
    #
    #   Guh::Device.find('{427a4a9a-c107-446f-aadf-f1b2abad607d1}')
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
    # Returns a list of recently discovered devices.
    #
    # Example:
    #
    #   Guh::Device.discover("{985195aa-17ad-4530-88a4-cdd753d747d7}", [{name: 'location', value: 'Salzburg'}])
    #
    def self.discover(device_class_id, discovery_params = [])
      response = get({
        id: generate_request_id,
        method: "Devices.GetDiscoveredDevices",
        params: {
          deviceClassId: device_class_id,
          discoveryParams: discovery_params
        }
      })

      if response['deviceError'] == 'DeviceErrorNoError'
        return response['deviceDescriptors']
      else
        raise Guh::DeviceError, response['deviceError']
      end
    end

    ##
    #
    # Creates a configured device and returns it's ID.
    #
    # Example for the "Elro Power Switch":
    #
    #   Guh::Device.add("{308ae6e6-38b3-4b3a-a513-3199da2764f8}", nil, {
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
    # To create a discovered device you have to provide a descriptor ID in the params:
    #
    #   Guh::Device.add("{985195aa-17ad-4530-88a4-cdd753d747d7}", "{727a4a9a-c187-446f-aadf-f1b2220607d1}")
    #
    def self.add(device_class_id, device_descriptor_id = nil, params = [])
      device_class = Guh::DeviceClass.find(device_class_id)

      if device_class['createMethods'].include? 'CreateMethodUser'
        add_configured_device(device_class_id, params)
      elsif device_class['createMethods'].include? 'CreateMethodDiscovery'
        add_discovered_device(device_class_id, device_descriptor_id, params)
      elsif device_class['createMethods'].include? 'CreateMethodAuto'
        # Nothing to do here
        # TODO should we raise an exception?
      end
    end

    ##
    #
    # Finishes a pairing process with a device. The user might have to push a button on the device.
    #
    # The +pairing_transaction_id+ can be obtained with the +add_discovered_device()+ method.
    #
    def self.confirm_pairing(pairing_transaction_id)
      response = get({
        id: generate_request_id,
        method: "Devices.PairDevice",
        params: {
          pairingTransactionId: pairing_transaction_id
        }
      })

      if response['deviceError'] == 'DeviceErrorNoError'
        return response
      else
        raise Guh::DeviceError, response['deviceError']
      end
    end

    ##
    #
    # Removes a configured device.
    #
    # Example:
    #
    #   device_id = Guh::Device.add("{ab73ad2f-6594-45a3-9063-8f72d365c5e5}", nil, [{name: 'familyCode', value: 'A'}])
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
      if response['deviceError'] == 'DeviceErrorNoError'
        return true
      else
        raise Guh::DeviceError, response['deviceError']
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

    private

    def self.add_configured_device(device_class_id, params)
      response = get({
        id: generate_request_id,
        method: "Devices.AddConfiguredDevice",
        params: {
          deviceClassId: device_class_id,
          deviceParams: params
        }
      })

      if response['deviceError'] == 'DeviceErrorNoError'
        return response['deviceId']
      else
        raise Guh::DeviceError, response['deviceError']
      end
    end

    def self.add_discovered_device(device_class_id, descriptor_id, params = [])
      device_class = Guh::DeviceClass.find(device_class_id)

      if device_class['setupMethod'] == 'SetupMethodJustAdd'
        add_discovered_device_just_add(device_class_id, descriptor_id, params)
      else
        add_discovered_device_pair(device_class_id, descriptor_id, params)
      end
    end

    def self.add_discovered_device_just_add(device_class_id, device_descriptor_id, params = [])
      response = get({
        id: generate_request_id,
        method: "Devices.AddConfiguredDevice",
        params: {
          deviceClassId: device_class_id,
          deviceDescriptorId: device_descriptor_id,
          deviceParams: params
        }
      })

      if response['deviceError'] == 'DeviceErrorNoError'
        return response['deviceId']
      else
        raise Guh::DeviceError, response['deviceError']
      end
    end

    def self.add_discovered_device_pair(device_class_id, descriptor_id, params = [])
      response = get({
        id: generate_request_id,
        method: "Devices.PairDevice",
        params: {
          deviceClassId: device_class_id,
          deviceDescriptorId: descriptor_id,
          deviceParams: params
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
