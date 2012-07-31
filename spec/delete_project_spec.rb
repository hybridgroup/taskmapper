require 'spec_helper'

describe "Delete project" do 
  let(:client) do 
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end

  context "Given the backend has 1 projects" do 
    it "Delete a project from the project repository" do 
      p = client.project! :name => 'Awesome Project', :description => 'Awesome' 
      client.projects.should have(1).items
      client.projects.delete(p).should be_true
      client.projects.should have(0).items
    end

  end
end

