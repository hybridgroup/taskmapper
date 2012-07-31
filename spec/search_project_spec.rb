require 'spec_helper'

describe "Search projects" do
  let(:client) do
    TaskMapper::Client.new :in_memory, :user => 'omar', :password => '1234'
  end
  
  context "Given the backend have projects" do
    before do
      client.project! :name => 'Awesome Project',
                      :description => 'This is awesome!'
      client.project! :name => 'Bored Project',
                      :description => 'This is bored'
      client.project! :name => 'Extra Bored Project',
                      :description => 'This is extra bored'
    end
    
    shared_examples_for :bored_project do
      its(:id) { should == 2 }
      its(:name) { should == 'Bored Project' }
      its(:description) { should == 'This is bored' }
      its(:created_at) { should be_a Time }
      it { should satisfy { |p| p.tasks.project_id == 2 } }
    end
    
    context "Retrieve all projects" do
      let(:search_results) { client.projects }
      
      subject { search_results }
    
      its(:count) { should == 3 }
    
      describe :first do
        subject { search_results.first }
        its(:id) { should == 1 }
        its(:name) { should == 'Awesome Project' }
        its(:description) { should == 'This is awesome!' }
        its(:created_at) { should be_a Time }
      end
    end
    
    context "Search projects with name containing 'Bored'" do
      let(:search_results) { client.projects.select { |project| project.name.include? 'Bored' } }
      subject { search_results }
      its(:count) { should == 2 }
      describe :project_names do
        subject { search_results.map { |p| p.name } }
        it { should == ['Bored Project', 'Extra Bored Project'] }
      end
    end
    
    context "Find a project by id" do
      subject { client.projects.find { |project| project.id == 2 } }
      it_behaves_like :bored_project
    end
    
    context "Find a project by id" do
      subject { client.projects.find 2 }
      it_behaves_like :bored_project
    end
    
    context "Find by attributes" do
      subject { client.projects.find :name => 'Bored Project' }
      it_behaves_like :bored_project
    end
    
    context "Given the provider does not define finder methods" do
      let(:client) { TaskMapper::Client.new :without_finders }
      
      context "Find a project by id" do
        subject { client.projects.find 2 }
        it_behaves_like :bored_project
      end
      
      context "Find by attributes" do
        subject { client.projects.find :name => 'Bored Project' }
        it_behaves_like :bored_project
      end
    end
    
    context "Find with dynamic" do
      context "Find by attributes" do
        subject { client.projects.find_by_name 'Bored Project' }
        it_behaves_like :bored_project
      end
    end
  end
  
  context "Given there are no projects" do
    context "Retrieve all" do
      subject { client.projects.to_a }
      it { should == [] }
    end
    
    context "Find a project by id" do
      subject { client.projects.find 2 }
      it { should be_nil }
    end    
  end
end
