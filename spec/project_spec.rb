require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Projects" do
  let(:tm) { TaskMapper.new(:dummy, {}) }
  let(:project_class) { TaskMapper::Provider::Dummy::Project }
  before(:each) do
    @ticketmaster = TaskMapper.new(:dummy, {})
    @project_class = TaskMapper::Provider::Dummy::Project
  end

  describe "with a connection to a provider" do
    context "when #projects" do 
      subject { tm.projects } 
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of project_class }
      it { subject.last.should be_an_instance_of project_class }
    end

    context "when #project with a hash is call" do 
      subject { tm.project(:name => "Whack whack what?") }
      it { should be_an_instance_of project_class }
      it { subject.name.should be_eql("Whack whack what?") }
    end

    context "when retreiving a project" do 
      subject { tm.projects.first } 
      it { subject.description.should_not be_nil }
      it { subject.description.should be_eql("Mock!-ing Bird") }
    end

    context "when #projects is call with an ID" do 
      subject { tm.projects(555) }
      it { should be_an_instance_of project_class }
      it { subject.id.should be_eql(555) } 
    end

    context "when #projects is call with an array of IDs" do 
      subject { tm.projects([555]) }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of project_class }
      it { subject.first.id.should be_eql(555) }
    end

    context "when #projects is call with a hash" do 
      subject { tm.projects(:id => 555) }
      it { should be_an_instance_of Array }
      it { subject.first.should be_an_instance_of project_class }
      it { subject.first.id.should be_eql(555) }
    end

    context "when #project is call" do 
      subject { tm.project }
      it { should be_eql project_class }
      it { subject.first.description be_eql("Mock!-ing Bird") }
      it { subject.last.description be_eql("Mock!-ing Bird") }
    end

    context "when #project is call with a hash" do 
      subject { tm.project.find(:first, :description => "Shocking Dirb") }
      it { should be_an_instance_of project_class }
      it { subject.description.should be_eql("Shocking Dirb") }
    end
  end
  
  describe "declaring a new project" do
    context "when calling #new" do 
      subject { tm.project.new(default_info) }
      it { should be_an_instance_of project_class }
      it { subject.name.should be_eql("Tiket Name  c") }
      it { subject.save.should be_true }
    end
  end
  
  describe "creating a new project" do
    context "when calling #create" do 
      subject { tm.project.create(default_info) }
      it { should be_an_instance_of project_class }
      it { subject.name.should be_eql("Tiket Name  c") }
    end
  end
  
  def default_info
    {:id => 777, :name => "Tiket Name  c", :description => "that c thinks the k is trying to steal it's identity"}
  end
end
