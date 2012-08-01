require 'spec_helper'

describe "Initialize TaskMapper" do
  context "Given the provider is not defined" do
    let(:error) { catch_error { TaskMapper.new :fantasy } }
    subject { error }
    it { should_not be_nil }
    it { should be_kind_of TaskMapper::Exceptions::ProviderNotFound }
    
    describe :message do
      subject { error.message }
      it { should match /Define module: TaskMapper::Providers::Fantasy/ }
    end
  end
end
