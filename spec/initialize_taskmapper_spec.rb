require 'spec_helper'

describe "Initialize TaskMapper" do
  context "Given the provider is not defined" do
    let(:error) do 
      catch_error(TaskMapper::Exceptions::ProviderNotFound) do 
        TaskMapper.new :fantasy
      end 
    end
    
    subject { error }
    it { should_not be_nil }
    
    describe :message do
      subject { error.message }
      it { should match /Define module: TaskMapper::Providers::Fantasy/ }
    end
  end
end
