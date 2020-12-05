class Main
    def initialize()
        complete = File.open("input.txt")
            .read
            .split("\n\n")
            .map { |p| parsePassport(p) }
            .filter { |p| p.isComplete() }

        correct = complete
            .filter { |p| p.isValid() }

        puts "Solution 1: " + complete.length().to_s
        puts "Solution 2: " + correct.length().to_s
    end

    def parsePassport(passportStr)
        passport = Passport.new()
        passportStr = passportStr.split(/\s|\n/)
        for entryStr in passportStr do
            key, value = entryStr.split(":")
            passport.set(key, value)
        end
        return passport
    end
end

class Passport
    def initialize()
        @fields = Hash.new
        @required = {
            "byr" => Constraint.new(/^(\d{4})$/, 1920, 2002),
            "iyr" => Constraint.new(/^(\d{4})$/, 2010, 2020),
            "eyr" => Constraint.new(/^(\d{4})$/, 2020, 2030),
            "hgt" => OrConstraint.new(
                        Constraint.new(/^(\d*)cm$/, 150, 193),
                        Constraint.new(/^(\d*)in$/, 59, 76)
                     ),
            "hcl" => Constraint.new(/^#((?:\d|[a-f]){6})$/, nil, nil),
            "ecl" => Constraint.new(/^(amb|blu|brn|gry|grn|hzl|oth)$/, nil, nil),
            "pid" => Constraint.new(/^(\d{9})$/, nil, nil)
        }
    end
    def set(key, value)
        @fields[key] = value
    end
    def getFields()
        return @fields, @valid
    end
    def isComplete()
        @complete = @required.keys
                .map { |f| @fields.has_key?(f) }
                .reduce { |b1, b2| b1 && b2 }
        return @complete
    end

    def isValid()
        @valid = true
        @required.each do |key, constraint| 
            @valid = @valid && constraint.correct(@fields[key])
        end
        return @valid
    end
end

class Constraint
    def initialize(regex, min, max)
        @regex = regex
        @min = min
        @max = max
    end
    def correct(str)
        if @min == nil && @max == nil then
            return str.match(@regex) != nil
        end
        
        match_data = str.match @regex
        if match_data == nil then
            return false
        end

        value = match_data[1].to_i
        return value >= @min && value <= @max
    end
end

class OrConstraint
    def initialize(c1, c2)
        @c1 = c1
        @c2 = c2
    end
    def correct(str)
        @c1.correct(str) || @c2.correct(str)
    end
end

Main.new