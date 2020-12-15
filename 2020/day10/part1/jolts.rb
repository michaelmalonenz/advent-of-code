joltages = IO.readlines('input').map { |line| line.strip.to_i }
joltages.sort!

# start with one for outlet and device respectively
num_ones = 1
num_threes = 1

current = 1
while current < joltages.length
    diff = joltages[current] - joltages[current - 1]
    if diff == 1
        num_ones += 1
    elsif diff == 3
        num_threes += 1
    end
    current += 1
end

puts "#{num_ones} * #{num_threes}"
puts "#{num_ones * num_threes}"
