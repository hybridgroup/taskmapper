require 'spec_helper'

describe "Search projects" do
  let(:tm) do
    TaskMapper.new :in_memory, :user => 'omar', :password => '1234'
  end
  
  context "Given the backend have projects" do
    before do
      tm.project! :name => 'Awesome Project',
                  :description => 'This is awesome!'
      tm.project! :name => 'Bored Project',
                  :description => 'This is bored'
      tm.project! :name => 'Extra Bored Project',
                  :description => 'This is extra bored'
    end
    
    context "Retrieve all projects" do
      let(:search_results) { tm.projects }
      
      subject { search_results }
    
      its(:count) { should == 3 }
    
      describe :first do
        subject { search_results.first }
        its(:id)          { should == 1 }
        its(:name)        { should == 'Awesome Project' }
        its(:description) { should == 'This is awesome!' }
        its(:created_at)  { should be_a Time }
      end
    end
    
    context "Search projects with name containing 'Bored'" do
      let(:search_results) { tm.projects.select { |project| project.name.include? 'Bored' } }
      subject { search_results }
      its(:count) { should == 2 }
      describe :project_names do
        subject { search_results.map { |p| p.name } }
        it { should == ['Bored Project', 'Extra Bored Project'] }
      end
    end
  end  
    
  
  context "Given there are no projects" do
    context "Retrieve all" do
      subject { tm.projects.to_a }
      it { should == [] }
    end
  end
end
