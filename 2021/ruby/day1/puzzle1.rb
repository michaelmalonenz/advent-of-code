increases = 0
previous = nil
IO.read('input').each_line do |line|
    num = line.to_i
    if !previous.nil?
        increases += 1 if num > previous
    end
    previous = num
end

puts increases

