require 'spec_helper'

describe "Initialize TaskMapper" do
  
  context "Given the provider module is not defined" do
    it "should raise provider not found error" do
      error = catch_error { TaskMapper.new :unknown } 
      error.should be_a TaskMapper::Exceptions::ProviderNotFound
      error.message.should match /Provider 'Unknown' was not found/i
      error.message.should match /In order to implement it/i
      error.message.should match /Define module/i
      error.message.should match /TaskMapper::Providers::Unknown/i
    end
  end
end
