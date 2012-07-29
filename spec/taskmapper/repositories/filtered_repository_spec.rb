require 'spec_helper'

describe TaskMapper::FilteredRepository do
  it "should filter elements" do
    filter = { :parent_id => 1 }
    provider = double :provider
    provider.should_receive(:list).with(filter).and_return([])
    
    repository = described_class.new :provider => provider,
      :filter => filter
    repository.to_a
  end
end
