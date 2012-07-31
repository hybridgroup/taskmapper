require 'spec_helper'

describe "Delete project" do 
  let(:client) do 
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end
  let(:projects) { client.projects }

  context "Given the backend has 2 projects" do 
    before do 
      client.project! :name => 'Awesome Project',
        :description => 'This is awesome!'

      client.project! :name => 'Bored Project',
        :description => 'This is bored'
    end

    subject { projects } 

    its(:count) { should has_size 2 }

    describe :delete do 
      subject { projects.first.delete }
      it { should be_true }

    end
  end
end

