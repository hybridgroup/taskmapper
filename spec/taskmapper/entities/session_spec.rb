require 'spec_helper'

module TaskMapper
  module Providers
    module Kanbanpad
      module Projects
      end
    end
  end
end

describe TaskMapper::Entities::Session do
  let(:provider) { double(:provider) }
  
  it "should create a project" do
    session = described_class.new :kanbanpad, 
      { :user => 'foo', :bar => 'bar' },
      :projects_provider => provider
      
    project = session.projects
  end
end
