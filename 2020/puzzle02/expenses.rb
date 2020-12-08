expenses = IO.readlines('input').map { |expense| expense.strip.to_i() }


expenses.each do |current|
    expenses.each do |tester|
        expenses.each do |third|
            if (current + tester + third == 2020)
                puts "#{current * tester * third}"
                exit
            end
        end
    end
end
