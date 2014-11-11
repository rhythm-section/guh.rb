require 'helper'

describe Guh::Rule do

  before :all do
    # Intertechno Remote
    @sender = create_configured_device("{ab73ad2f-6594-45a3-9063-8f72d365c5e5}", [
      {name: 'familyCode', value: 'A'}
    ])

    # Intertechno Switch
    @receiver = create_configured_device("{324219e8-7c53-41b5-b314-c2900cd15252}", [
      {name: 'familyCode', value: 'A'},
      {name: 'button', value: 1}
    ])

  end

  it "should return a list of all rules" do
    response = Guh::Rule.all

    response.should be_an_instance_of(Array)
  end

  it "should create a new rule" do
    senderDeviceClass = Guh::DeviceClass.all.detect{|d| d['id']==@sender['deviceClassId']}

    eventTypeId = senderDeviceClass['eventTypes'].first['id']

    actionId = Guh::ActionType.all(@receiver['deviceClassId']).first['id']

    event = {
      eventTypeId: eventTypeId,
      deviceId: @sender['id'],
      params: [
        {name: 'inRange', value: true}
      ]
    }

    action = {
      actionTypeId: actionId,
      deviceId: @receiver['id'],
      params: [
        {name: 'power', value: true}
      ]
    }

    -> {
      response = Guh::Rule.add(event, action)
    }.should_not raise_error

    pending "TODO How do we know we were successful?"

  end

end
