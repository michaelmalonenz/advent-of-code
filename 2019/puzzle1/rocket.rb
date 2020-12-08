total = 0

IO.readlines('input').each do |line|
    total += (line.strip.to_i() / 3) - 2
end

puts total