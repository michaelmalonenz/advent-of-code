answers = IO.readlines('input').map { |line| line.strip }

class GroupAnswers
    def initialize()
        @num_people = 0
        @answers = Hash.new { |hash, key| hash[key] = 0 }
    end

    def add_person(answer_line)
        @num_people += 1
        answer_line.each_char do |char|
            @answers[char] += 1
        end
    end

    def get_all_answered_count()
        count = 0
        @answers.each_pair do |key, value|
            count += 1 if value == @num_people
        end
        return count
    end
end

current_group = GroupAnswers.new()

total = 0
answers.each do |line|
    if line.empty?
        total += current_group.get_all_answered_count()
        current_group = GroupAnswers.new()
        next
    end

    current_group.add_person(line)
end

puts total