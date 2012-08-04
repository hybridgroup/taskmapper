require 'spec_helper'

describe "Update a Project" do
  context "Given the Awesome Project exist" do
    let(:tm) do
      TaskMapper.new :in_memory, :user => 'omar', :password => '1234'
    end
    
    let(:project) { tm.project! :name => 'P1', 
                                :description => 'desc' }
       
    describe "Given I change the name" do
      before(:all) do
        project.name = "P2"
        project.instance_eval do
          updated_at = Time.new 1984, 02, 20
        end
      end
      
      describe :result do
        subject { project.save }

        it { should == true }
      end
      
      describe :updated_project do
        subject   { tm.projects.find_by_name "P2" }
        
        its(:id)  { should == project.id }
        
        describe :updated_at do
          subject { project.updated_at }
          its(:day) { should == Time.now.day }
        end
      end
    end
  end
end
