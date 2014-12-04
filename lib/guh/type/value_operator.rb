module Guh
  module Type
    class ValueOperator

      ##
      #
      # Returns a list of value operators that may be used for the creation of rules
      #
      def self.all
        introspect = Guh::Base.introspect
        introspect['types']['ValueOperator']
      end
    end
  end
end
