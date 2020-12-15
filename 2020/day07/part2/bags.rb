require 'set'

rules = IO.readlines('input')

BAGS = {}

rules.each do |line|
    if line =~ %r{^(.+)\sbags\scontain\s(.+)\.$}x
        container_bag = $1
        contained = []
        if $2 != 'no other bags'
            contained_bags = $2.split(',').each do |bag|
                if bag =~ %r{(\d+)\s(.+)\sbags?}x
                    $1.to_i.times { contained << $2 }
                end
            end
        end
        BAGS[container_bag] = contained
    else
        puts 'no match'
    end
end

def count_bags_of_holding(bag_name)
    contained = BAGS[bag_name]
    count = contained.size()
    contained.each do |bag|
        count += count_bags_of_holding(bag)
    end
    return count
end

puts count_bags_of_holding('shiny gold')