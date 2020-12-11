CYPHER = IO.readlines('input').map { |line| line.strip.to_i }
WINDOW_SIZE = 25

def current_index_valid?(index)
    window = CYPHER[index - WINDOW_SIZE, WINDOW_SIZE]
    window.each_with_index do |a, i|
        window.each_with_index do |b, j|
            next if i == j
            return true if a + b == CYPHER[index]
        end
    end
    return false
end

current = WINDOW_SIZE
while current < CYPHER.length
    raise "'#{CYPHER[current]}' was not valid" if !current_index_valid?(current)
    current += 1
end

puts "All were valid"