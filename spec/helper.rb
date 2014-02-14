require 'rubygems'
require 'rspec'

require 'hive_rpc_wrapper'

require 'json'
require 'socket'
class FakeUnixSocketServer < TCPServer
  
  def initialize(port=1234)
    super
  end
  
  def run
    STDOUT.write "[Server] #{self.addr}"
    
    @running = true
    while @running do
      client = self.accept       # Wait for a client to connect
      
      STDOUT.write "[Server] #{client.inspect}"
      
      request = client.gets
      
      if request.chop.downcase == "halt"
        @running = false
        STDOUT.write "[Server] Received 'halt' - Miller time!"
        client.close
      else
        STDOUT.write "[Server] #{request}"
        client.puts '[{"id": "foo"},'+"\n"+'{"id": "bar"}]'
        client.close
      end
      
      sleep 1/60
    end
  ensure
    self.close
  end
  
end
