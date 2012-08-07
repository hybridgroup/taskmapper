require 'spec_helper'

describe "Find a project" do
  let(:tm) do
    TaskMapper.new :in_memory, :user => 'omar', :password => '1234'
  end
  
  context "Given the following projects" do
    before do
      tm.project! :name => 'Awesome Project',
                  :description => 'This is awesome!'
      tm.project! :name => 'Bored Project',
                  :description => 'This is bored'
      tm.project! :name => 'Extra Bored Project',
                  :description => 'This is extra bored'
    end  
    
    shared_examples_for :bored_project do
      its(:id)          { should == 2 }
      its(:name)        { should == 'Bored Project' }
      its(:description) { should == 'This is bored' }
      its(:created_at)  { should be_a Time }
      its(:updated_at)  { should be_a Time }
    end
    
    context "Find a project by id" do
      subject { tm.projects.find { |project| project.id == 2 } }
      it_behaves_like :bored_project
    end

    context "Find a project by id" do
      subject { tm.projects.find 2 }
      it_behaves_like :bored_project
    end

    context "Find by attributes" do
      subject { tm.projects.find :name => 'Bored Project' }
      it_behaves_like :bored_project
    end

    context "Given the provider does not define finder methods" do
      let(:tm) { TaskMapper.new :without_finders }
      
      context "Find a project by id" do
        subject { tm.projects.find 2 }
        it_behaves_like :bored_project
      end
      
      context "Find by attributes" do
        subject { tm.projects.find :name => 'Bored Project' }
        it_behaves_like :bored_project
      end
    end

    context "Find with dynamic" do
      context "Find by attributes" do
        subject { tm.projects.find_by_name 'Bored Project' }
        it_behaves_like :bored_project
      end
    end
  end
  
  context "Given there are no projects" do
    context "Find a project by id" do
      subject { tm.projects.find 2 }
      it { should be_nil }
    end    
  end
end
