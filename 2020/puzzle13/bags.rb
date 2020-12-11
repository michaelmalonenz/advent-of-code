require 'set'

rules = IO.readlines('input')

BAGS = {}

rules.each do |line|
    if line =~ %r{^(.+)\sbags\scontain\s(.+)\.$}x
        container_bag = $1
        contained = []
        if $2 != 'no other bags'
            contained_bags = $2.split(',').each do |bag|
                if bag =~ %r{\d+\s(.+)\sbags?}x
                    contained << $1
                end
            end
        end
        BAGS[container_bag] = contained
    else
        puts 'no match'
    end
end

def get_bags_of_holding(bag_name)
    containers = []
    BAGS.each_pair do |key, value|
        containers << key if value.include? bag_name
    end
    result = Set.new(containers)
    containers.each do |container|
        result += get_bags_of_holding(container)
    end
    return result
end

puts get_bags_of_holding('shiny gold').size()