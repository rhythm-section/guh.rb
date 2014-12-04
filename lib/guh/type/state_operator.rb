module Guh
  module Type
    class StateOperator

      ##
      #
      # Returns a list of state operators that may be used for the creation of state based rules
      #
      def self.all
        introspect = Guh::Base.introspect
        introspect['types']['StateOperator']
      end
    end
  end
end
