require 'spec_helper'
describe "Search projects" do
  let(:client) do
    pending "Needs refactor" do
      TaskMapper::Client.new :kanbanpad, 
        { :user => 'foo', :password => 'bar' },
        :projects_provider => projects_provider,
        :tasks_provider => tasks_provider
    end
  end
  
  let(:search_results) { client.projects }
  
  let(:projects_provider) { double :projects_provider }
  let(:tasks_provider) { double :tasks_provider }
  
  context "Given the backend has 2 projects" do
    let(:backend_projects) do
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
    
    before do 
      projects_provider.should_receive(:list)
      .and_return backend_projects  
    end
    
    describe :search_results do
      subject { search_results }
    
      its(:count) { should == 2 }
    
      describe :first do
        subject { search_results.first }
        its(:id) { should == 1 }
        its(:name) { should == 'p1' }
        its(:description) { should == 'desc' }
        its(:created_at) { should be_a Time }
      end
    end
  end
end
