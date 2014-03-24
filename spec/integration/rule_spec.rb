require 'helper'

describe HiveRpcWrapper::Rule do
  
  before :all do
    # Wifi Device
    @sender = create_configured_device("{bd216356-f1ec-4324-9785-6982d2174e17}", {
      mac: "00:11:22:33:44:55"
    })
    
    # Intertechno Switch
    @receiver = create_configured_device("{324219e8-7c53-41b5-b314-c2900cd15252}", {
      familyCode: 'A',
      buttonCode: 1
    })
    
  end
  
  it "should return a list of all rules" do
    response = HiveRpcWrapper::Rule.all
    
    response['status'].should eq('success')
  end
  
  it "should create a new rule" do
    # TODO: remove ugly workaround
    senderDeviceClass = HiveRpcWrapper::Device.supported['params']['deviceClasses'].detect{|d| d['id']==@sender['deviceClassId']}
    eventId = senderDeviceClass['events'].first['id']
    
    actionId = HiveRpcWrapper::ActionType.all(@receiver['deviceClassId'])['params']['actionTypes'].first['id']
    
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
    
    response = HiveRpcWrapper::Rule.add(event, action)
    response['status'].should eq('success')
    
    pj response
  end
  
end
