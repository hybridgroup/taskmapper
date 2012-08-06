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

    let(:project_id) { 1 }

    context "Given I change its name" do
      before(:all) do
        project.update_attributes  :name => "Super Awesome Project",
          :description => "Something Super Awesome"
      end

      describe :save do
        subject { project.save }
        it { should == true }
      end

      context "Given I read the same project" do 
        subject   { tm.projects.find_by_id project_id }
        its(:name) { should == "Super Awesome Project" }
        its(:description) { should == "Something Super Awesome" }

        describe :updated_at do
          subject { project.updated_at }
          its(:day) { should == Time.now.day }
        end

      end
    end
  end
end
