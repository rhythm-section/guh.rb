require 'helper'

describe Guh::Rule do
  
  before :all do
    # Intertechno Remote
    @sender = create_configured_device("{ab73ad2f-6594-45a3-9063-8f72d365c5e5}", {
      familyCode: 'A'
    })
    
    # Intertechno Switch
    @receiver = create_configured_device("{324219e8-7c53-41b5-b314-c2900cd15252}", {
      familyCode: 'A',
      buttonCode: 1
    })
    
  end
  
  it "should return a list of all rules" do
    response = Guh::Rule.all
    
    response.should be_an_instance_of(Array)
  end
  
  it "should create a new rule" do
    senderDeviceClass = Guh::Device.supported.detect{|d| d['id']==@sender['deviceClassId']}
    eventId = senderDeviceClass['events'].first['id']
    
    actionId = Guh::ActionType.all(@receiver['deviceClassId']).first['id']
    
    event = {
      eventTypeId: eventId,
      deviceId: @sender['id'],
      params: {inRange: true}
    }
    
    action = {
      actionTypeId: actionId,
      deviceId: @receiver['id'],
      params: {
        power: true
      }
    }
    
    -> {
      # response = Guh::Rule.add(event, action)
    }.should_not raise_error
    
    pending "TODO How do we know we were successful?"
    
  end
  
end
