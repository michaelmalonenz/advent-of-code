INVALID_VALUE = 21806024

CYPHER = IO.readlines('input').map { |line| line.strip.to_i }

current = 0
while current < CYPHER.length
    break if CYPHER[current] == INVALID_VALUE
    total = 0
    index = current
    while index < CYPHER.length
        total += CYPHER[index]
        if total > INVALID_VALUE
            break
        elsif total == INVALID_VALUE
            nums = CYPHER[current, (index - current + 1)]
            puts nums.min() + nums.max()
            exit(0)
        end
        index += 1
    end
    current += 1
end

puts "Did not find the value"
exit(1)
