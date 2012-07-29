require 'spec_helper'

describe TaskMapper::DefaultProvider do
  before do
    @provider = TaskMapper::DefaultProvider.new "Project"
  end
  
  specify do
    lambda { @provider.list }
      .should raise_error(NotImplementedError, 
        /Provider must implement Project#list operation/)
  end
  
  specify do
    lambda { @provider.list :limit => 10 }
      .should raise_error(NotImplementedError, 
        /Provider must implement Project#list\(Hash\) operation/)
  end
  
  specify do
    lambda { @provider.find }
      .should raise_error(NotImplementedError, 
        /Provider must implement Project#find operation/)
  end
  
  specify do
    lambda { @provider.find 1 }
      .should raise_error(NotImplementedError, 
        /Provider must implement Project#find\(Fixnum\) operation/)
  end
  
  specify do
    lambda { @provider.delete }
      .should raise_error(NotImplementedError, 
        /Provider must implement Project#delete operation/)
  end
  
  specify do
    lambda { @provider.update }
      .should raise_error(NotImplementedError, 
        /Provider must implement Project#update operation/)
  end

  it "Move this behaviour to provider"
end
