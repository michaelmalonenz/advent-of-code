seat_codes = IO.readlines('input')

seat_ids = []

def get_seat_row(seat_code)
    bottom = 0
    top = 127
    seat_code[0,7].each_char do |char|
        if char == 'F' then
            top = top - ((top - bottom) / 2) - 1
        elsif char == 'B' then
            bottom = bottom + ((top - bottom) / 2) + 1
        else
            raise "Unknown Instruction: #{char}"
        end
    end
    raise 'Mismatched columns' unless bottom == top
    return top
end

def get_seat_column(seat_code)
    bottom = 0
    top = 7
    seat_code[7,3].each_char do |char|
        if char == 'L' then
            top = top - ((top - bottom) / 2) - 1
        elsif char == 'R' then
            bottom = bottom + ((top - bottom) / 2) + 1
        else
            raise "Unknown Instruction: #{char}"
        end
    end
    raise 'Mismatched rows' unless bottom == top
    return top
end

seat_codes.each do |seat_code|
    row = get_seat_row(seat_code)
    column = get_seat_column(seat_code) 
    seat_ids << column + row * 8
end

seat_ids.sort!

current = seat_ids[0]
seat_ids.each do |id|
    if current != id
        puts current
        exit()
    end
    current += 1
end