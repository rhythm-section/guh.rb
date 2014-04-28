require "guh/version"

require 'json'
require 'socket'

require "guh/base"
require "guh/action_type"
require "guh/action"
require "guh/device"
require "guh/plugin"
require "guh/rule"
require "guh/event_type"
require "guh/event"

module Guh
  # Your code goes here...
  
  class ResponseError < Exception; end
  class ArgumentError < Exception; end
  
end
