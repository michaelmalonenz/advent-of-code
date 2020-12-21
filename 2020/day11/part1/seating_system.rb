class Ferry
    def initialize(filename)
        @seats = File.readlines(filename).map(&:strip)

        @row_count = @seats.length
        @col_count = @seats[0].length
    end

    def count_occupied_adjacent_seats(seat_row, seat_col)
        count = 0
        [-1, 0, 1].each do |x|
            [-1, 0, 1].each do |y|
                next if x ==0 && y == 0
                x_pos = seat_row + x
                y_pos = seat_col + y
                if (x_pos >= 0 && x_pos < @col_count && y_pos >= 0 && y_pos < @row_count)
                    count += 1 if @seats[y_pos][x_pos] == '#'
                end
            end
        end
        return count
    end

    def run_step()
        change_count = 0
        seats = []
        @row_count.times do |y|
            row = []
            @col_count.times do |x|
                seat = @seats[y][x]
                if seat != '.'
                    occupied_adjacent_seats = count_occupied_adjacent_seats(x, y)
                    if seat == 'L' && occupied_adjacent_seats == 0
                        change_count += 1
                        row << '#'
                    elsif seat == '#' && occupied_adjacent_seats >= 4
                        change_count += 1
                        row << 'L'
                    else
                        row << seat
                    end
                else
                    row << seat
                end
            end
            seats << row.join('')
        end
        @seats = seats
        return change_count
    end

    def count_occupied_seats()
        count = 0
        @row_count.times do |y|
            @col_count.times do |x|
                count += 1 if @seats[y][x] == '#'
            end
        end
        return count
    end

    def to_s()
        return @seats.join("\n")
    end
end


ferry = Ferry.new('input')
changes = ferry.run_step()
while changes != 0
    # puts '==================================='
    # puts ferry
    changes = ferry.run_step()
end
# puts '==================================='
#     puts ferry
# puts '==================================='
puts ferry.count_occupied_seats()

