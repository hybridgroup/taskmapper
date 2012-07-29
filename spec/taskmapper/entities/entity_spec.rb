require 'spec_helper'

describe TaskMapper::Entities::Entity do
  before do
    @entity = Object.new
    @entity.extend TaskMapper::Entities::Entity
  end
  
  it "should be able to set and read id attribute" do
    @entity.id = 1
    @entity.id.should == 1
  end
  
  it "should be able to set and read created_at attribute" do
    @entity.created_at = Time.now
    @entity.created_at.should be_a Time
  end
end
