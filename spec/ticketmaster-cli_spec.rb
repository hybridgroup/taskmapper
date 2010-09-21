$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'

require 'fileutils'

Spec::Runner.configure do |config| end
# Tests for the cli
# I'm not quite sure what the most effective way to test this is...
describe "Ticketmaster CLI" do
  before(:all) do
    @ticket = File.dirname(__FILE__) + '/../bin/tm'
    @cli_dir = File.dirname(__FILE__) + '/../lib/ticketmaster/cli'
  end
  
  it "should output help if no command given" do
    help = `#{@ticket}`
    $?.should == 0
    help.should include('Usage: tm [options] COMMAND [command_options]')
  end
  
  it "should be able to show help pages" do
    `#{@ticket} help`.should include(File.read(@cli_dir + '/commands/help/help'))
    `#{@ticket} help config`.should include(File.read(@cli_dir + '/commands/help/config'))
    `#{@ticket} help console`.should include(File.read(@cli_dir + '/commands/help/console'))
  end
  
  it "should be able to add and edit config info" do
    pending
  end
  
  it "should be able to open up a console" do
    pending
  end
  
  describe :generate do
    it "should generate provider skeleton w/o runtime errors" do
      provider_name = "test-provider"
      expected_name = "ticketmaster-#{provider_name}"
      begin
        generate = `#{@ticket} generate #{provider_name}`
        $?.should == 0
        File.exists?(expected_name).should == true
      ensure
        FileUtils.remove_dir(expected_name) if File.exists? expected_name
      end
    end  
    
    it "should not prefix 'ticketmaster' when not asked to" do
      provider_name = "test-provider"
      begin
        generate = `#{@ticket} generate _#{provider_name}`
        $?.should == 0
        File.exists?(provider_name).should == true
      ensure
        FileUtils.remove_dir(provider_name) if File.exists? provider_name
      end
    end
  end
  
end
