program = IO.read('input').strip().split(',')

program.each_with_index do |intcode, i|
    program[i] = intcode.to_i()
end

# Restore to 1202 program alarm state
program[1] = 12
program[2] = 2

instruction_pointer = 0
opcode = 0

while true do
    opcode = program[instruction_pointer]
    case opcode
    when 1
        left_pos = program[instruction_pointer + 1]
        right_pos = program[instruction_pointer + 2]
        result_pos = program[instruction_pointer + 3]
        program[result_pos] = program[left_pos] + program[right_pos]
        instruction_pointer += 4
    when 2
        left_pos = program[instruction_pointer + 1]
        right_pos = program[instruction_pointer + 2]
        result_pos = program[instruction_pointer + 3]
        program[result_pos] = program[left_pos] * program[right_pos]
        instruction_pointer += 4
    when 99
        break
    end
end

puts program[0]
