module HiveRpcWrapper
  class Base
    
    # Hive Core's IP address
    # Default: +127.0.0.1+
    def self.hive_ip_address; @@hive_ip_address; end
    def self.hive_ip_address=(hia); @@hive_ip_address=hia; end
    @@hive_ip_address = "127.0.0.1"
    
    # Hive Core's port
    # Default: +1234+
    def self.hive_port; @@hive_port; end
    def self.hive_port=(hia); @@hive_port=hia; end
    @@hive_port = 1234
    
    def self.get(request_hash)
      request_string = hash_to_json(request_hash)
      
      puts "[Client] #{request_string}"
      
      response = ""
      
      client do |c|
        puts "[Client] #{c.inspect}"
        
        c.puts(request_string)
        
        end_of_response = false
        
        while line = c.gets
          response << line
        end
      end
      
      return JSON::parse(response)
    end
    
    def self.send(message)
      client do |c|
        c.puts(message)
      end
    end
    
    # Configuration DSL helper method.
    #
    # == Usage/Example:
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
      1
    end
    
    def self.client(&block)
      client = TCPSocket.open(@@hive_ip_address, @@hive_port)
      yield client
      client.close
    end
    
    def self.hash_to_json(hash)
      JSON::dump(hash) + "\n"
    end
  end
end
