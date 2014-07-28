module Guh
  ##
  # This class wraps everything related to available Devices.
  #
  class DeviceClass < Base

    ##
    #
    # Returns a list of all supported Devices.
    #
    # Example:
    #
    #   Guh::DeviceClass.all
    #   # => a list of all supported devices
    #
    def self.all(options={})
      params = {}
      params['vendorId'] = options[:vendor_id] unless options[:vendor_id].nil?

      response = get({
        id: generate_request_id,
        method: "Devices.GetSupportedDevices",
        params: params
      })

      return response['deviceClasses']
    end

    ##
    #
    # Finds a DeviceClass with a specific ID
    #
    # Example:
    #
    #   Guh::DeviceClass.find("{2062d64d-3232-433c-88bc-0d33c0ba2ba6}")
    #   # => a list of all supported devices of a specific vendor
    #
    def self.find(id)
      device_classes = self.all

      device_class = device_classes.detect{|dc| dc['id']==id}

      if device_class
        return device_class
      else
        raise DeviceClassNotFound, "Could not find a DeviceClass with the id #{id}"
      end
    end

    ##
    #
    def self.discover(id, options={})
      params = {deviceClassId: id}
      params['discoveryParams'] = options

      response = get({
        id: generate_request_id,
        method: "Devices.GetDiscoveredDevices",
        params: params
      })

      if response['success']
        return response['deviceDescriptors']
      else
        raise ResponseError, response['errorMessage']
      end
    end

  end
end
