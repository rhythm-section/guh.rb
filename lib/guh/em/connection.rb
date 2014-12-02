require 'eventmachine'

module Guh
  ##
  # This class wraps everything related to Notifications.
  #

  module EM
    class Connection < ::EventMachine::Connection

      def onmessage(&block)
        @onmessage = block
      end

      def post_init
        request_string = Guh::Base.hash_to_json({id: Guh::Base.generate_request_id, method: "JSONRPC.SetNotificationStatus", params: { enabled: true } })
        send_data(request_string)

        @message = ""
      end

      def receive_data(data)

        data.each_line do |line|
          @message << line

          if line.match(/^\}\n/)
            trigger_on_message(@message)

            @message = ""
          end
        end
      end

      def unbind
        # TODO implement a callback to enable the notification of all clients about lost connection
      end

      private

      def trigger_on_message(message)
        begin
          @onmessage.call(JSON::parse(message))
        rescue Exception => e
          puts "--> rescue in guh.rb: #{e.inspect}"
          return {}
        end
      end

    end
  end
end
