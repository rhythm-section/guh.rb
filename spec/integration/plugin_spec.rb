require 'helper'

describe Guh::Plugin do
  
  it "should return a list of all loaded plugins" do
    response = Guh::Plugin.all
    
    response.should be_an_instance_of(Array)
  end
  
  it "should add params to the Plugin config" do
    pending("Implement after difference between PluginConfig & PluginParams is clear")
  end
  
end
