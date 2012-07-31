require 'spec_helper'

module TaskMapper
  module Providers
    module Kanbanpad
      module Projects
        include InMemoryProvider
      end
      
      module Tasks
        include InMemoryProvider
      end
    end
  end
end

describe "Search projects" do
  pending do
  let(:search_results) { client.projects }
  
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
end
