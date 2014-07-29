class Concierge
  LOCKER_COUNT = 3000 # We'll assume they can be evenly distributed among sizes
  attr_accessor :lockers, :checked_bags

  def initialize
    @lockers, @checked_bags = {},{}
    @available_ids          = [*1..LOCKER_COUNT]
    @sizes                  = ["S","M","L"]
    @count_per_size         = LOCKER_COUNT / @sizes.length
    @sizes.each { |size| generate_lockers(size) }
  end

  def check_bag bag
    claim_number = @lockers.reject{ |_k,locker| locker.capacity != bag.size }.first.tap{|l| return nil if l.nil?}[0]

    @checked_bags[claim_number] = @lockers.delete(claim_number)
    claim_number
  end

  def claim_bag claim_number
    begin
      locker = @checked_bags.delete(claim_number)
      @lockers[claim_number] = locker # Make locker available
      locker.capacity
    rescue  # I can't find your bag.
      nil
    end
  end

  private

  def generate_lockers size
    @count_per_size.times do
      @lockers[@available_ids.shift] = Locker.new(size)
    end
  end
end
