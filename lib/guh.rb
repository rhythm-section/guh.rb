require "guh/version"

require 'json'
require 'socket'

require "guh/base"
require "guh/action"
require "guh/device"
require "guh/device_class"
require "guh/event_type"
require "guh/event"
require "guh/plugin"
require "guh/rule_type"
require "guh/rule"
require "guh/state_type"
require "guh/state"

require "guh/vendor"

require "guh/type/state_operator"
require "guh/type/value_operator"

require "guh/em/connection"
require "guh/em/notifications"

module Guh
  # Your code goes here...

  class ConnectionError < Exception; end
  class ResponseError < Exception; end
  class ArgumentError < Exception; end
  class DeviceError < Exception; end
  class ActionError < Exception; end
  class DeviceClassNotFound < Exception; end

end
