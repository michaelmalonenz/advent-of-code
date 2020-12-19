def bin_fmt(int)
    return int.to_s(2).rjust(36, '0')
end

class BitMask
    def initialize(mask_string)
        @masks = []
        @address_mask = 0x0F_FF_FF_FF_FF
        @mask = 0
        i = 0
        mask_string.reverse.each_char do |char|
            if char == 'X'
                @address_mask &= ~(1 << i)
            else
                @mask |= (char.to_i << i)
            end
            i += 1
        end

        i = 0
        mask_string.reverse.each_char do |char|
            if char == 'X'
                new_masks = [ (0 << i) | @mask, (1 << i) | @mask ]
                if @masks.empty?
                    @masks = new_masks
                else
                    masks = []
                    @masks.each do |mask|
                        new_masks.each do |new_mask|
                            masks << (mask | new_mask)
                        end
                    end
                    @masks = masks
                end
            end
            i += 1
        end
    end

    def each(int)
        @masks.each do |mask|
            yield (int & @address_mask) | mask
        end
    end
end

def emulate_instructions(instruction_file)
    puts "Emulating --- #{instruction_file} ----"
    program = File.readlines(instruction_file).map(&:strip)
    memory = {}
    bitmask = nil
    
    program.each do |instruction|
        if instruction =~ %r{^mask\ =\ (.*)$}x
            bitmask = BitMask.new($1)
        elsif instruction =~ %r{^mem\[(\d+)\]\ =\ (\d+)$}x
            address = $1.to_i
            value = $2.to_i
            bitmask.each(address) do |result_address|
                memory[result_address] = value
            end
        end
    end
    
    sum = 0
    memory.each_value do |mem|
        sum += mem
    end

    puts sum
    return sum
end

class TestFailed < Exception
end

ans = emulate_instructions('test_input')
raise TestFailed.new("#{ans} != 208") unless ans == 208

ans = emulate_instructions('test_input2')
raise TestFailed.new("#{ans} != 52") unless ans == 52

emulate_instructions('input')
