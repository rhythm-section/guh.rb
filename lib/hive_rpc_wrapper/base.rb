module HiveRpcWrapper
  ##
  # The base class which all the specific wrapper classes inherit from. It provides some shared code to make development easier.
  # 
  class Base
    
    # Getter/Setter for the hive_ip_address attribute
    def self.hive_ip_address #:nodoc:
      @@hive_ip_address 
    end
    def self.hive_ip_address=(hia) #:nodoc:
      @@hive_ip_address=hia
    end 
    @@hive_ip_address = "127.0.0.1"
    
    # Getter/Setter for the hive_port attribute
    def self.hive_port #:nodoc: 
       @@hive_port
    end
    def self.hive_port=(hia) #:nodoc:
      @@hive_port=hia
    end
    @@hive_port = 1234
    
    ##
    # 
    # <b>Don't use this unless you know what you are doing!</b>
    # 
    # Send a request to Hive Core and fetch the Response. This is a utility method used by the subclasses.
    # 
    def self.get(request_hash)
      request_string = hash_to_json(request_hash)
      
      response = nil
      client do |c|
        c.puts(request_string)
        
        response = fetch_message(c)
      end
      
      return response
    end
    
    ##
    # 
    # Configuration DSL helper method.
    # 
    # The default values are: 
    # * +hive_ip_address+: 127.0.0.1
    # * +hive_port+: 1234
    # 
    # Example:
    # 
    #   HiveRpcWrapper.configure do |config|
    #     config.hive_ip_address = 10.0.0.1
    #     config.hive_port = 6789
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
      client = TCPSocket.open(@@hive_ip_address, @@hive_port)
      connection_message = fetch_message(client)
      if connection_message['status']=='connected'
        yield client
      else
        # TODO raise connection error
      end
    ensure
      client.close
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
    
    def self.hash_to_json(hash)
      JSON::dump(hash) + "\n"
    end
  end
end
