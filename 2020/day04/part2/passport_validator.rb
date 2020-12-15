raw_lines = IO.readlines('input').map{ |line| line.strip }

class Passport
    attr_writer :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

    EYE_COLOURS = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

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
        if (!@byr.nil? && !@iyr.nil? && !@eyr.nil? &&
            !@hgt.nil? && !@hcl.nil? && !@ecl.nil? &&
            !@pid.nil?)
            return false unless @byr.length == 4 && @byr.to_i >= 1920 && @byr.to_i <= 2002
            return false unless @iyr.length == 4 && @iyr.to_i >= 2010 && @iyr.to_i <= 2020
            return false unless @eyr.length == 4 && @eyr.to_i >= 2020 && @eyr.to_i <= 2030
            if (@hgt =~ %r{^(\d+)cm$}x)
                height = $1.to_i
                return false unless height >= 150 && height <= 193
            elsif (@hgt =~ %r{^(\d+)in$}x)
                height = $1.to_i
                return false unless height >= 59 && height <= 76
            else
                return false
            end
            return false unless @hcl =~ %r{^\#[0-9a-f]{6}$}x
            return false unless EYE_COLOURS.include? @ecl
            return false unless @pid =~ %r{^[0-9]{9}$}x
            # cid (Country ID) - ignored, missing or not.
            return true
        else
            return false
        end
    end

    def []=(key, value)
        self.send("#{key}=", value)
    end

    def to_s
        return "byr: #{@byr}, iyr: #{@iyr}, eyr: #{@eyr}, hgt: #{@hgt}, hcl: #{@hcl}, ecl: #{@ecl}, pid: #{@pid}, cid: #{@cid}"
    end
end

current_passport = Passport.new()

num_valid = 0

raw_lines.each do |line|
    if line.empty?
        if current_passport.valid?
            num_valid += 1
        end
        current_passport = Passport.new()
    else
        line.split.each do |field|
            key, value = *field.split(':')
            current_passport[key] = value
        end
    end
end

puts num_valid
