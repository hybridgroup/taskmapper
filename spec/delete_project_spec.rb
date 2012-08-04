require 'spec_helper'

describe "Delete project" do 
  let(:tm) do 
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end

  context "Given the backend have projects" do 
    before(:all) do 
      tm.project! :name => 'Awesome Projet', 
        :description => 'This is awesome!'
      tm.project! :name => 'Bored Project',
        :description => 'This is bored'
    end
    let(:project) { tm.projects.first }
    let(:projects) { tm.projects }

    context "Delete a single project" do 
      subject { projects }
      its(:count) { should == 2 }

      describe :delete do 
        subject { projects.delete project } 
        it { should be_true }
      end
      its(:count) { should == 1 }

    end
  end
end

