class PasswordPolicyChecker
    def initialize(first, second, letter, password)
        @first = first.to_i - 1
        @second = second.to_i - 1
        @letter = letter
        @password = password
    end

    def valid?()
        return false if (@first > @password.length || @second > @password.length)
        return ((@password[@first] == @letter) || (@password[@second] == @letter)) &&
                (@password[@first] != @password[@second])
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
