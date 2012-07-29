require 'spec_helper'

describe TaskMapper::Entities::Comment do
  describe :initialize do
    before do
      @comment = described_class.new :author => 'omar',
        :body => 'my comment',
        :parent => :dummy_parent 
    end
    
    it "should initialize passing a hash" do
      @comment = described_class.new :author => 'omar',
        :body => 'my comment',
        :parent => :dummy_parent
        
      @comment.author.should == 'omar'
      @comment.body.should == 'my comment'
      @comment.parent == :dummy_parent
    end
  end
end
