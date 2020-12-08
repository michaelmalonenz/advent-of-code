$program = [99]

def init_program(noun, verb)
    $program = IO.read('input').strip().split(',')

    $program.each_with_index do |intcode, i|
        $program[i] = intcode.to_i()
    end
    $program[1] = noun
    $program[2] = verb
end

def run_program()
    instruction_pointer = 0
    opcode = 0

    while true do
        opcode = $program[instruction_pointer]
        case opcode
        when 1
            left_pos = $program[instruction_pointer + 1]
            right_pos = $program[instruction_pointer + 2]
            result_pos = $program[instruction_pointer + 3]
            $program[result_pos] = $program[left_pos] + $program[right_pos]
            instruction_pointer += 4
        when 2
            left_pos = $program[instruction_pointer + 1]
            right_pos = $program[instruction_pointer + 2]
            result_pos = $program[instruction_pointer + 3]
            $program[result_pos] = $program[left_pos] * $program[right_pos]
            instruction_pointer += 4
        when 99
            break
        end
    end
    return $program[0]
end


for noun in 0..99 do
    for verb in 0..99 do
        init_program(noun, verb)
        result = run_program()
        puts noun * 100 + verb if (result == 19690720)
    end
end