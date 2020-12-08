geography = IO.readlines('input').map { |line| line.strip }

LINE_LENGTH = 31

slopes = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
]

tree_nums = []

slopes.each do |right, down|
    current_line = 0
    current_index = 0
    num_trees = 0
    while (current_line < geography.length)
        num_trees += 1 if (geography[current_line][current_index] == '#')
        current_index += right
        current_index = current_index % LINE_LENGTH
        current_line += down
    end
    tree_nums << num_trees
end

total = 1

tree_nums.each do |num|
    total *= num
end

puts total