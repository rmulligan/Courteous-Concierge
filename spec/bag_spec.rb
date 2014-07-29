require 'spec_helper'

describe Bag do
  before(:each) do
    @bag = Bag.new("S")
  end

  it "should have a size" do
    expect(@bag).to respond_to(:size)
  end
end
