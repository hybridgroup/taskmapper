require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe TaskMapper do
  context "when calling new it should always return a ticketmaster instance" do 
    subject { TaskMapper.new(:dummy, {}) }
    it { should be_an_instance_of TaskMapper }
    it { should be_a_kind_of TaskMapper::Provider::Dummy }
  end

end
