class PasswordPolicyChecker
    def initialize(min, max, letter, password)
        @min = min.to_i
        @max = max.to_i
        @letter = letter
        @password = password
    end

    def valid?()
        count = 0
        @password.each_char do |char|
            count += 1 if char == @letter
        end
        return count >= @min && count <= @max
    end
end

checkers = IO.readlines('input').map do |line|
    if line =~ %r{^(\d+)\-(\d+)\s*?([a-z]):\s+([a-z]+)$}x
        PasswordPolicyChecker.new($1, $2, $3, $4)
    else
        raise line
    end
end

valid_count = 0
checkers.each do |checker|
    valid_count += 1 if checker.valid?
end

puts "Valid: #{valid_count}"
