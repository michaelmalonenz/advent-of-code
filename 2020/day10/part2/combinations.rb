joltages = IO.readlines('input').map { |line| line.strip.to_i }
joltages << 0
joltages << joltages.max() + 3
joltages.sort!

JOLTS = joltages
CACHE = {}

def find_combinations(n)
    return 1 if n == JOLTS.length - 1
    return CACHE[n] if CACHE.has_key? n

    combinations = 0
    i = n + 1
    while i < JOLTS.length
        if JOLTS[i] - JOLTS[n] <= 3
            combinations += find_combinations(i)
        end
        i += 1
    end
    CACHE[n] = combinations
    return combinations
end

result = find_combinations(0)
puts result