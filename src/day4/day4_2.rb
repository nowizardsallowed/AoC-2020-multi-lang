# Passport validation

validate_numerical = -> (key, value) {
  # Look up the value range and check against it.
  # If the value range is a hash, we need to parse the value to find the hgt
  # units.
    
  validate_range = FIELDS[key][:range]
  if ( validate_range.kind_of?(Hash) ) then 
    validate_range = validate_range[value.chars().last(2).join]
    
    if ( !validate_range ) then 
      return false
    end
  end

  value = value.to_i()
  return ( value >= validate_range[0] && value <= validate_range[1] )
}

validate_hexdec = -> (key, value) {
  # Leaving this here for clarity that you can solve the problem this way.
  # validate_arr = value.chars().map() { | c | c =~ FIELD[key][:regex] }
  
  return ( value.length == FIELDS[key][:range] ) && ((value =~ FIELDS[key][:regex]) != nil)
}

validate_string = -> (key, value) {
  return ( FIELDS[key][:range].include?(value) )
}

validate_pass = -> (k, v) {
  return true
}

FIELDS = {
          "byr" => 
            { 
              range: [1920, 2002],
              func: validate_numerical,
            },
          "iyr" =>
            {
              range: [2010, 2020],
              func: validate_numerical
            },
          "eyr" => 
            {
              range: [2020, 2030],
              func: validate_numerical
            },
          "hgt" =>
            {
              range: {
                "in" => [59, 76],
                "cm" => [150, 193]
              },
              func: validate_numerical
            },
          "pid" =>
            {
              range: 9,
              func: validate_hexdec,
              regex: /[0-9]{9}/
            },
          "hcl" =>
            {
              range: 7,
              func: validate_hexdec,
              regex: /#+([0-9a-f]{6})/
            },
          "ecl" =>
            {
              range: ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"],
              func: validate_string
            },
          "cid" =>
            {
              func: validate_pass
            }
}

def validate(passport_string)
  present_bool = FIELDS.map() { | k, v | 
    if ( k != "cid" ) then
      passport_string.include?(k.to_s+":")
    end
  }

  # CID is optional so we're ignoring it, leading to a nil in the last elem.
  present_bool.pop() # Remove it.

  if (!present_bool.all?) then
    return false 
  end

  passport_hash = Hash[passport_string.split(' ').map() { | e | 
    e.split(':')
  }]

  valid_bool = passport_hash.map() { | k, v | 
    FIELDS[k][:func].call(k, v) }
  return valid_bool.all?
end


passport_string = ""
count = 0
f = File.open('input')

while ( true ) do
  l = f.gets
  case l
    when "\n", nil then
      if validate(passport_string) then
        count += 1
      end
      
      if ( !l ) then
        puts count
        return
      end
      passport_string = ""
  else
    passport_string += (l.tr("\n", ' '))
  end
end

