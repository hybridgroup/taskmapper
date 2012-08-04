require 'spec_helper'

describe "Update a Project" do
  context "Given the Awesome Project exist" do
    let(:tm) do
      TaskMapper.new :in_memory, :user => 'omar', :password => '1234'
    end
    
    let(:project) do 
      p = tm.project! :name => 'Awesome Project', 
                      :description => 'Something Awesome'
      p.instance_eval do
        updated_at = Time.new 1984, 02, 20
      end
      p
    end
    
    describe "Given I change its name" do
      before(:all) do
        project.name = "Super Awesome Project"
      end
      
      describe :save do
        subject { project.save }
        it { should == true }
      end
      
      describe :updated_project do
        subject   { tm.projects.find_by_name "Super Awesome Project" }
        
        describe :updated_at do
          subject { project.updated_at }
          its(:day) { should == Time.now.day }
        end
      end
    end
    
    describe "Given I change its description" do
      before(:all) do
        project.description = "Something Super Awesome"
      end
      
      describe :save do
        subject { project.save }
        it { should == true }
      end
      
      describe :updated_project do
        subject   { tm.projects.find_by_description "Something Super Awesome" }
        
        describe :updated_at do
          subject { project.updated_at }
          its(:day) { should == Time.now.day }
        end
      end
    end
  end
end
