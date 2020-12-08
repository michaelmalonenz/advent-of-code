class WireMarker
    attr_writer :wire_a, :wire_b
    attr_reader :wire_a, :wire_b

    def initialize(a=false, b=false)
        @wire_a = a
        @wire_b = b
    end
end


class Direction
    attr_reader :x, :y, :length

    def initialize(dir, length)
        @y = 0
        @x = 0
        case dir
        when 'L'
            @x = -1
        when 'R'
            @x = 1
        when 'U'
            @y = 1
        when 'D'
            @y = -1
        else
            raise dir
        end
        @length = length.to_i
    end

    def to_s
        return "#{@x},#{@y}-#{@length}"
    end
end


class Manhattan
    def initialize(grid_size, start_x, start_y)
        @grid_size = grid_size
        @start_x = start_x
        @start_y = start_y
        @x = @start_x
        @y = @start_y
        @wires = []
        @grid = Array.new(@grid_size) { Array.new(@grid_size) }
        @grid[@x][@y] = WireMarker.new(true, true)
    end

    def parse_input_file(filename)
        IO.readlines(filename).each do |line|
            instructions = line.strip().split(',')
            wire = []
            instructions.each do |instruction|
                wire.push(Direction.new(instruction[0], instruction[1, instruction.length - 1]))
            end
            @wires << wire
        end
    end

    def trace_wires()
        @wires.each_with_index do |wire, i|
            wire.each do |dir|
                dir.length.times do
                    @y += dir.y
                    @x += dir.x
                    raise "X: #{@x}, Y: #{@y}" if @x < 0 || @y < 0
                    @grid[@x][@y] = WireMarker.new() if @grid[@x][@y].nil?
                    if (i == 0)
                        @grid[@x][@y].wire_a = true
                    else
                        @grid[@x][@y].wire_b = true
                    end
                end
            end
        end        
    end

    def find_min_manhattan_distance()
        manhattans = []
        @grid_size.times do |x|
            @grid_size.times do |y|
                next if x == @start_x && y == @start_y
                if !@grid[x][y].nil? && @grid[x][y].wire_a && @grid[x][y].wire_b
                    manhattans.push((x - @start_x).abs() + (y - @start_y).abs())
                end
            end
        end

        return manhattans.min()
    end
end


test_1 = Manhattan.new(20, 1, 1)
test_1.parse_input_file('test1_input')
test_1.trace_wires()
puts test_1.find_min_manhattan_distance()

test_2 = Manhattan.new(500, 50, 50)
test_2.parse_input_file('test2_input')
test_2.trace_wires()
puts test_2.find_min_manhattan_distance()

test_3 = Manhattan.new(500, 50, 50)
test_3.parse_input_file('test3_input')
test_3.trace_wires()
puts test_3.find_min_manhattan_distance()
