module Guh
  ##
  # This class wraps everything related to Rules.
  #
  class Rule < Base

    ##
    #
    # Returns a list of all Rules.
    #
    # Example:
    #
    #   Guh::Rule.all
    #
    def self.all
      response = get({
        id: generate_request_id,
        method: "Rules.GetRules"
      })

      response['ruleIds']
    end

    ##
    #
    # Creates a new Rule.
    #
    # Example:
    #
    #   Guh::Rule.add(event, action)
    #
    def self.add(event_descriptor_list, actions)
      unless actions.is_a?(Array)
        actions = [actions]
      end

      get({
        id: generate_request_id,
        method: "Rules.AddRule",
        params: {
          eventDescriptorList: event_descriptor_list,
          actions: actions
        }
      })
    end

    ##
    #
    # Removes a Rule.
    #
    # Example:
    #
    #   Guh::Rule.remove(rule_id)
    #
    def self.remove(rule_id)

    end

  end
end
