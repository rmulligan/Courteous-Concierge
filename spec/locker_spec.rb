require 'spec_helper'

describe Locker do
  before :each do
    @locker = Locker.new("S")
  end

  it "should look and smell like a locker" do
    expect(@locker).to be_an_instance_of(Locker)
  end

  it "should be of some size" do
    expect(@locker).to respond_to(:capacity)
  end
end
