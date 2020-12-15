raw_lines = IO.readlines('input').map{ |line| line.strip }

class Passport
    attr_writer :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid
    attr_reader :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

    def initialize()
        @byr = nil
        @iyr = nil
        @eyr = nil
        @hgt = nil
        @hcl = nil
        @ecl = nil
        @pid = nil
        @cid = nil
    end

    def valid?
        return (
            !@byr.nil? &&
            !@iyr.nil? &&
            !@eyr.nil? &&
            !@hgt.nil? &&
            !@hcl.nil? &&
            !@ecl.nil? &&
            !@pid.nil?)
    end

    def []=(key, value)
        self.send("#{key}=", value)
    end
end

passports = []
current_passport = Passport.new()

raw_lines.each do |line|
    if line.empty?
        passports << current_passport
        current_passport = Passport.new()
    else
        line.split.each do |field|
            key, value = *field.split(':')
            current_passport[key] = value
        end
    end
end

num_valid = 0
passports.each do |pass|
    num_valid += 1 if pass.valid?
end

puts num_valid
