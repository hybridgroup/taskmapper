require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Tickets" do
  let(:tm) { TaskMapper.new(:dummy, {}) }
  let(:project_class) { TaskMapper::Provider::Dummy::Project }
  let(:ticket_class) { TaskMapper::Provider::Dummy::Ticket }
  let(:project) { tm.projects.first }

  describe "for a Project" do
    context "when #tickets" do 
      subject { project.tickets }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of ticket_class }
    end

    context "when searching wanting back all tickets that match the query" do 
      subject { project.tickets([999]) }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of ticket_class }
      it { subject.first.id.should be_eql(999) }
    end

    context "when passing an query hash" do 
      subject { project.tickets(:id => 999) }
      it { should be_an_instance_of Array }
    end

    context "when searching wanting back the first ticket that matches the query" do 
      subject { project.ticket }
      it { should be_eql TaskMapper::Provider::Dummy::Ticket } 
    end

    context "when querying using default ID query" do 
      subject { project.ticket(888) } 
      it { should be_an_instance_of ticket_class }
    end

    context "when passing an id to #ticket" do 
      subject { project.ticket(888) } 
      it { subject.id.should be_eql(888) }
    end

    context "when passing a hash to #ticket" do 
      subject { project.ticket(:id => 888) }
      it { should be_an_instance_of ticket_class }
    end

    context "when passing an id to #ticket" do 
      subject { project.ticket(888) } 
      it { subject.id.should be_eql(888) }
    end
  end
end
