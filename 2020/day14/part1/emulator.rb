program = File.readlines('input').map(&:strip)

class BitMask
    def initialize(mask_string)
        @or_mask = 0
        @and_mask = 0xF_FF_FF_FF_FF
        i = 0
        mask_string.reverse.each_char do |char|
            if char == '1'
                @or_mask |= 1 << i
            elsif char == '0'
                @and_mask &= ~(1 << i)
            end
            i += 1
        end
    end
    
    def apply(int)
        return (int & @and_mask) | @or_mask
    end
end

memory = Array.new(65635, 0)
mask = nil

program.each do |instruction|
    if instruction =~ %r{^mask\ =\ (.*)$}x
        mask = BitMask.new($1)
    elsif instruction =~ %r{^mem\[(\d+)\]\ =\ (\d+)$}x
        memory[$1.to_i] = mask.apply($2.to_i)
    end
end

sum = 0
memory.each do |mem|
    sum += mem
end

puts sum
