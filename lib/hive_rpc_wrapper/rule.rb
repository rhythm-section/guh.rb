module HiveRpcWrapper
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
    #   HiveRpcWrapper::Rule.all
    # 
    def self.all
      get({
        id: generate_request_id,
        method: "Rules.GetRules"
      })
    end
    
    ##
    # 
    # Creates a new Rule.
    # 
    # Example:
    # 
    #   HiveRpcWrapper::Rule.add(event, action)
    # 
    def self.add(event, actions)
      unless actions.is_a?(Array)
        actions = [actions]
      end
      
      get({
        id: generate_request_id,
        method: "Rules.AddRule",
        event: event,
        actions: actions
      })
    end
    
    ##
    # 
    # Removes a Rule.
    # 
    # Example:
    # 
    #   HiveRpcWrapper::Rule.remove(rule_id)
    # 
    def self.remove(rule_id)
      
    end
    
  end
end
