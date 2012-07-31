require 'spec_helper'

describe "Search projects" do
  let(:client) do
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end
  
  let(:search_results) { client.projects }
  
  context "Given the backend has 2 projects" do
    before do
      client.project! :name => 'Awesome Project',
                      :description => 'This is awesome!'
      
      client.project! :name => 'Bored Project',
                      :description => 'This is bored'
    end
    
    context "Given no search criteria" do    
      describe :search_results do
        subject { search_results }
      
        its(:count) { should == 2 }
      
        describe :first do
          subject { search_results.first }
          its(:id) { should == 1 }
          its(:name) { should == 'Awesome Project' }
          its(:description) { should == 'This is awesome!' }
          its(:created_at) { should be_a Time }
        end
      end
    end
  end
end
