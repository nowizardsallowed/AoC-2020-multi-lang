# Passport validation
# An input file contains passport details across multiple lines.
# Seek until we find a newline or the EOF and concat the details into one string
# Validate the string contains all of the fields below, count all that pass.

FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

def validate(passport_string) 
  result = FIELDS.map() { | s |
    passport_string.include?(s+':')
  }
  return (result.all?)
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
    passport_string += (l.tr("\n", ''))
  end
end
