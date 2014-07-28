require 'helper'

describe Guh::Action do

  before :all do
    # Elro Switch
    device_class_id = "{308ae6e6-38b3-4b3a-a513-3199da2764f8}"

    @device = create_configured_device(device_class_id, [
      {name: 'channel1',  value: true},
      {name: 'channel2',  value: false},
      {name: 'channel3',  value: false},
      {name: 'channel4',  value: false},
      {name: 'channel5',  value: false},
      {name: 'A',  value: false},
      {name: 'B',  value: false},
      {name: 'C',  value: false},
      {name: 'D',  value: false},
      {name: 'E', value: false}
    ])

    # Get all the possible actions for the device
    actions = Guh::ActionType.all(device_class_id)

    # Just use the first action
    @action = actions.first
  end

  it "should execute a single action" do
    -> {
      response = Guh::Action.execute(@device['id'], @action['id'], [{name: 'power', value: true}])
    }.should_not raise_error
  end

  it 'should fail if the wrong params are provided' do

    -> {
      response = Guh::Action.execute(@device['id'], @action['id'], [])
    }.should raise_error
  end

end
