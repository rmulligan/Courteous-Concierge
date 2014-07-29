require_relative '../locker'
require_relative '../concierge'
require_relative '../bag'

RSpec.configure do |config|
  config.color     = true
  config.formatter = :documentation
end

def fill_up
  ['S','M','L'].each do |size|
    1000.times do
      @concierge.check_bag(Bag.new(size))
    end
  end
end

def empty
  3000.times do |i|
    @concierge.claim_bag(i+1)
  end
end
