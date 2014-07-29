require 'spec_helper'

describe Concierge do
  before(:each) do
    @concierge = Concierge.new
  end

  it "should know about lockers" do
    expect(@concierge).to respond_to(:lockers)
  end

  it "should return 3000 lockers" do
    expect(@concierge.lockers.size).to eq(3000)
  end

  it "should have 1000 small lockers" do
    expect(@concierge.lockers.reject{|_k,locker| locker.capacity != 'S'}.size).to eq(1000)
  end

  it "should have 1000 medium lockers" do
    expect(@concierge.lockers.reject{|_k,locker| locker.capacity != 'M'}.size).to eq(1000)
  end

  it "should have 1000 large lockers" do
    expect(@concierge.lockers.reject{|_k,locker| locker.capacity != 'L'}.size).to eq(1000)
  end

  it "should have a max locker id of 3000" do
    expect(@concierge.lockers.keys.max).to be(3000)
  end

  context "checking bags" do
    before(:each) do
      @bag = Bag.new('S')
    end

    it "should issue a claim ticket" do
      receipt = @concierge.check_bag(@bag)
      expect(receipt).to be_an_instance_of(Fixnum)
    end

    it "should put bag in approprately spacious locker" do
      claim_number = @concierge.check_bag(@bag)
      expect(@concierge.checked_bags[claim_number].capacity).to eq(@bag.size)
    end

    it "should put bag in approprately medium locker" do
      claim_number = @concierge.check_bag(@bag)
      expect(@concierge.checked_bags[claim_number].capacity).to eq(@bag.size)
    end

    it "should put bag in approprately small locker" do
      claim_number = @concierge.check_bag(@bag)
      expect(@concierge.checked_bags[claim_number].capacity).to eq(@bag.size)
    end

    it "should not present occupied locker as available" do
      claim_number     = @concierge.check_bag(@bag)
      new_claim_number = @concierge.check_bag(@bag)
      expect(claim_number == new_claim_number).to eq(false)
    end

    it "should have 1 less available locker" do
      @concierge.check_bag(@bag)
      expect(@concierge.lockers.length).to eq(2999)
    end

    it "should return false if all lockers are full" do
      1000.times do
        @concierge.check_bag(@bag)
      end
      expect(@concierge.check_bag(@bag)).to eq(false)
    end

    it "should fill up" do
      fill_up
      expect(@concierge.lockers.length).to eq(0)
    end
  end

  context "Claiming Bag" do
    it "should return a small bag" do
      bag = Bag.new("S")
      claim_number = @concierge.check_bag(bag)
      expect(@concierge.claim_bag(claim_number)).to eq('S')
    end

    it "should return a medium bag" do
      bag = Bag.new("M")
      claim_number = @concierge.check_bag(bag)
      expect(@concierge.claim_bag(claim_number)).to eq('M')
    end

    it "should return a large bag" do
      bag = Bag.new("L")
      claim_number = @concierge.check_bag(bag)
      expect(@concierge.claim_bag(claim_number)).to eq('L')
    end

    it "should return nil if not found" do
      expect(@concierge.claim_bag(4000)).to eq(nil)
    end

    it "should empty" do
      fill_up
      empty
      expect(@concierge.lockers.length).to eq(3000)
    end
  end
end
