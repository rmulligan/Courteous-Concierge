require_relative 'concierge'
require_relative 'locker'
require_relative 'bag'
require 'colorize'

system "clear"

@concierge = Concierge.new

puts "Welcome to Concierge Software.".green

while true
  puts "Enter 'C' for Checkins, 'V' for Claims, or 'X' to exit:".yellow
  command = gets.chomp

  case command.downcase
  when 'c'
    puts "#######################".blue
    puts "##### Checking in #####".blue
    puts "#######################".blue
    puts "\n\n"
    puts "Enter Bag Size (S,M,L):".green
    bag_size = gets.chomp.upcase
    labels      = {'S' => 'small', 'M' => 'medium', 'L' => 'large'}

    if ['S','M','L'].include? bag_size
      bag = Bag.new(bag_size)
      claim_number = @concierge.check_bag(bag)
      if claim_number.nil?
        puts "Sorry, there are no more #{labels[bag_size]} lockers available.\n\n".red
      else
        puts "Your Claim Number is".yellow + " #{claim_number}.\n\n".red
      end
    else
      puts "That is not a size.\n\n".red
    end
  when 'v'
    puts "#######################".blue
    puts "#####  Claim Bag  #####".blue
    puts "#######################".blue
    puts "\n\n"
    puts "Enter Claim Number:".green
    claim_number = gets.chomp.to_i

    unless claim_number == 0
      labels      = {'S' => 'small', 'M' => 'medium', 'L' => 'large'}
      claim_size  = @concierge.claim_bag(claim_number)
      puts claim_size.nil? ? "\nBag not found.\n\n".red : "\nHere is your #{labels[claim_size]} bag.\n\n".blue
    else
      puts "Invalid Claim Number\n\n".red
    end
  when 'x'
    system "clear"
    puts "Thank you for using Concierge Software.".green
    exit 0
  else
    puts "Oops. I don't know what you're trying to say.".red
  end
end
