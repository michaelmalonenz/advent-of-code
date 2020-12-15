geography = IO.readlines('input').map { |line| line.strip }

LINE_LENGTH = 31

current_line = 0
current_index = 0
num_trees = 0

while (current_line < geography.length)
    num_trees += 1 if (geography[current_line][current_index] == '#')
    current_index += 3
    current_index = current_index % LINE_LENGTH
    current_line += 1
end

puts num_trees