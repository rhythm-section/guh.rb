require 'helper'

describe Guh::EventType do

  it "should get something back" do
    # Elro Switch
    device_class_id = "{308ae6e6-38b3-4b3a-a513-3199da2764f8}"

    # Get all the possible events for the device
    response = Guh::EventType.all(device_class_id)

    response.should be_an_instance_of(Array)

    pending "Right now we get empty responses for all events"
  end

end
