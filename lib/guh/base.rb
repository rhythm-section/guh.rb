module Guh
  ##
  # The base class which all the specific wrapper classes inherit from. It provides some shared code to make development easier.
  # 
  class Base
    
    # Getter/Setter for the guh_ip_address attribute
    def self.guh_ip_address #:nodoc:
      @@guh_ip_address 
    end
    def self.guh_ip_address=(hia) #:nodoc:
      @@guh_ip_address=hia
    end 
    @@guh_ip_address = "127.0.0.1"
    
    # Getter/Setter for the guh_port attribute
    def self.guh_port #:nodoc: 
       @@guh_port
    end
    def self.guh_port=(hia) #:nodoc:
      @@guh_port=hia
    end
    @@guh_port = 1234
    
    ##
    # 
    # Returns everything that is going on inside guh Core
    # 
    # Example:
    # 
    #   Guh::Base.introspect
    # 
    def self.introspect
      get({
        id: generate_request_id,
        method: "JSONRPC.Introspect",
      })
    end
    
    ##
    # 
    # <b>Don't use this unless you know what you are doing!</b>
    # 
    # Send a request to guh Core and fetch the Response. This is a utility method used by the subclasses.
    # 
    def self.get(request_hash)
      request_string = hash_to_json(request_hash)
      
      response = nil
      client do |c|
        c.puts(request_string)
        
        response = fetch_message(c)
      end
      
      if response['status']=='success'
        return response['params']
      else
        raise Guh::ResponseError, "The Request was not successful"
      end
    end
    
    ##
    # 
    # Configuration DSL helper method.
    # 
    # The default values are: 
    # * +guh_ip_address+: 127.0.0.1
    # * +guh_port+: 1234
    # 
    # Example:
    # 
    #   Guh.configure do |config|
    #     config.guh_ip_address = 10.0.0.1
    #     config.guh_port = 6789
    #   end
    # 
    def self.configure(&block)
      yield self
    end
    
    private
    
    def self.generate_request_id
      999999
    end
    
    def self.client(&block)
      client = TCPSocket.open(@@guh_ip_address, @@guh_port)
      
      connection_message = fetch_message(client)
      
      # TODO check guh-core version and raise error if incompatible with this gem's version
      # TODO look for timeout or connection refused errors
      
      yield client
    end
    
    def self.fetch_message(client)
      end_of_message = false
      
      message = ""
      while (line = client.gets)
        message << line
        
        end_of_message = true if line.match(/^\}\n/)
        
        break if end_of_message
      end
      
      return JSON::parse(message)
    end
    
    ##
    #
    # Converts a regular hash into a list of hashes.
    # 
    # Example: 
    # 
    # convert_map_to_list_of_maps({
    #   power: true,
    #   pin: 1,
    #   family_code: 'A'
    # })
    #
    # Returns: 
    # 
    # [
    #   {power: true},
    #   {pin: 1},
    #   {family_code: 'A'}
    # ]
    # 
    def self.convert_map_to_list_of_maps(map)
      list = []
      map.each do |key, value|
        list << {key => value}
      end
      return list
    end
    
    def self.hash_to_json(hash)
      JSON::dump(hash) + "\n"
    end
  end
end
