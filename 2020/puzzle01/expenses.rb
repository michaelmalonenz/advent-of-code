expenses = IO.readlines('input').map { |expense| expense.strip.to_i() }


expenses.each do |current|
    expenses.each do |tester|
        if (current + tester == 2020)
            puts "#{current * tester}"
        end
    end
end
