require 'spec_helper'

describe TaskMapper::Client do
  let(:client) do
    described_class.new :kanbanpad, 
      { :user => 'foo', :password => 'bar' },
      :projects_provider => projects_provider
  end
  
  let(:projects_provider) { double :projects_provider }
  
  describe :project! do
    let(:project) do 
      client.project! :name => 'test', 
        :description => 'this is a test'
    end
    
    subject { project }
    
    before do
      projects_provider.should_receive(:create)
        .with(:name => 'test', :description => 'this is a test')
        .and_return 1
    end
    
    it { should be_a TaskMapper::Entities::Project }
    its(:id) { should == 1 }
    its(:name) { should == 'test' }
    its(:description) { should == 'this is a test'}
    its(:session) { should == client.session }   
  end
  
  describe :projects do
    let(:projects) { client.projects }
    
    subject { projects }
    
    before { projects_provider.should_receive(:list).and_return projects_attrs }
    
    let(:projects_attrs) do 
      [{
        :id => 1,
        :name => 'p1',
        :description => 'desc',
        :created_at => Time.now,
      },
      {
        :id => 2,
        :name => 'p2',
        :description => 'desc'
      }]
    end
    
    it { should be_a Array }
    its(:count) { should == 2 }
    
    describe :first do
      subject { projects.first }
      it { should be_a TaskMapper::Entities::Project }
      its(:id) { should == 1 }
      its(:name) { should == 'p1' }
      its(:description) { should == 'desc' }
      its(:created_at) { should be_a Time }
    end
  end
end
