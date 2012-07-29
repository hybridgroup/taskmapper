require 'spec_helper'

describe TaskMapper::Entities::Project do
  let(:project) { described_class.new :name => 'test' }
  
  it "should not allow empty name" do
    lambda {
      project.name = nil
    }.should raise_error TaskMapper::Exceptions::RequiredAttribute, 
      /Attribute 'name' is required/
  end
end
