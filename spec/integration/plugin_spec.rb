require 'helper'

describe HiveRpcWrapper::Plugin do
  
  it "should return a list of all loaded plugins" do
    response = HiveRpcWrapper::Plugin.all
    
    response['status'].should eq('success')
  end
  
  it "should add params to the Plugin config" do
    pending("Implement after difference between PluginConfig & PluginParams is clear")
  end
  
end
