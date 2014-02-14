require 'helper'

describe HiveRpcWrapper::TriggerType do
  
  def start_server
    @thread = Thread.new do
      socket_server = FakeUnixSocketServer.new
      socket_server.run
    end
  end
  
  def stop_server
    HiveRpcWrapper::Base.send("halt")
  end
  
  it "should get something back" do
    puts "before server"
    start_server
    puts "after server"
    
    HiveRpcWrapper::Base.configure do |c|
      c.hive_ip_address = "0.0.0.0"
      c.hive_port = 1234
    end
    
    sleep 0.5
    puts HiveRpcWrapper::TriggerType.all.inspect
    
    stop_server
  end
  
end
