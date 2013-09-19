require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe TaskMapper do
  describe "#new" do
    it "returns a TaskMapper instance" do
      instance = TaskMapper.new :dummy, {}
      expect(instance).to be_a TaskMapper
      expect(instance).to be_a_kind_of TaskMapper::Provider::Dummy
    end
  end
end
