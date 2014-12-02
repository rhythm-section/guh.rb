module Guh
  module EM
    class Notifications

      def self.subscribe
        EventMachine.connect Guh::Base.guh_ip_address, Guh::Base.guh_port, Connection do |connection|
          yield connection
        end
      end

    end
  end
end
