answers = IO.readlines('input').map { |line| line.strip }

current_group = {}

total = 0
answers.each do |line|
    if line.empty?
        total += current_group.keys.count
        current_group = {}
    end

    line.each_char do |answer|
        current_group[answer] = true
    end
end

puts total