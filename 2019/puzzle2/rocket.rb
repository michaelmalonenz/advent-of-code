total = 0

def calc_fuel_for_mass(mass)
    fuel = (mass / 3) - 2
    if (fuel >= 0) then
        fuel += calc_fuel_for_mass(fuel)
    else
        return 0
    end
    return fuel
end

IO.readlines('input').each do |line|
    total += calc_fuel_for_mass(line.strip.to_i())
end

puts total