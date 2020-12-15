class RepeatedInstruction < Exception
end

def swap_instruction(instruction)
    op, arg = instruction.split(' ')
    if op == 'nop'
        return "jmp #{arg}"
    elsif op == 'jmp'
        return "nop #{arg}"
    end
    return instruction
end

def run_attempt(flip_instruction, ops)
    accumulator = 0
    instruction_pointer = 0
    instructions_used = []

    ops[flip_instruction] = swap_instruction(ops[flip_instruction])

    while instruction_pointer < ops.length
        if instructions_used.include? instruction_pointer
            raise RepeatedInstruction.new("About to execute instruction '#{instruction_pointer + 1}' for the second time")
        end
        instructions_used << instruction_pointer
        instruction = ops[instruction_pointer]
        # puts "#{instruction_pointer + 1} #{instruction}"
        op, arg = *instruction.split(' ')
        case op
        when 'nop'
            instruction_pointer += 1
        when 'acc'
            accumulator += arg.to_i
            instruction_pointer += 1
        when 'jmp'
            instruction_pointer += arg.to_i
        else
            raise "Unknown instruction '#{op}'"
        end
    end
    return accumulator
end

instructions = IO.readlines('input').map { |line| line.strip }
instructions.length.times do |i|
    acc = nil
    begin
        acc = run_attempt(i, Array.new(instructions))
    rescue RepeatedInstruction
        next
    end
    puts 'Program terminated cleanly'
    puts "Accumulator was #{acc}"
    exit(0)
end