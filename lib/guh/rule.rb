module Guh
  ##
  # This class wraps everything related to Rules.
  #
  class Rule < Base

    def self.find(rule_id)
      response = get({
        id: generate_request_id,
        method: "Rules.GetRuleDetails",
        params: { ruleId: rule_id }
      })
    end

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
    #   Guh::Rule.add(params)
    #
    def self.add(params)
      get({
        id: generate_request_id,
        method: "Rules.AddRule",
        params: params
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
      get({
        id: generate_request_id,
        method: "Rules.RemoveRule",
        params: { ruleId: rule_id }
      })
    end

  end
end
