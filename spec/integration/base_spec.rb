require 'helper'

describe Guh::Device do

  it 'should raise an exception if Guh Core is not running' do
    Guh::Base.configure do |c|
      c.guh_ip_address = "0.0.0.0"
      c.guh_port = 7890 # <---- wrong port to provoke excpetion
    end

    expect { Guh::Base.introspect }.to raise_error(Errno::ECONNREFUSED)
  end

  it 'should raise an exception if Guh Core does not respond with success on connect' do
    pending("TODO: Find a way to provoke this.")
  end

end
