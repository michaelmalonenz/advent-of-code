instructions = IO.readlines('input').map { |line| line.strip }

accumulator = 0
instruction_pointer = 0

instructions_used = []

while true
    if instructions_used.include? instruction_pointer
        puts "About to execute instruction '#{instruction_pointer}' for the second time"
        puts "acc was '#{accumulator}'"
        exit(0)
    end
    instructions_used << instruction_pointer
    instruction = instructions[instruction_pointer]
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
