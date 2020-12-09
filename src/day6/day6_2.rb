# Customs declaration
# Individuals in groups answer questions a..z
# Each group is seperated in the input with a newline.
# Each individual is seperated in its group with a trailing newline character.
# Note: This solution required the input to have a newline on its last line instead of an EOF as
#	readlines will cease before we can add the last count - the work around is to accum c with
# 	the output of get_answer_count when we leave the .each(), but that's ugly.

def get_answer_count(inp_str)
	

	a = inp_str.split("\n")
	if ( a.length > 1 ) then
		# Join the array into a single string.
		# Split the string into individual chars.
		# Group the characters into hashes containing the character as an index and an array of 
		#	the repeating chars as a value.
		# Select only the the hashes that have arrays larger than one element (multiple occurances)
		# Map() ensures the return value (to the length check) is an array of chars that repeat.
		# Check to see if all of the strings include these characters.	
		h = a.join.chars.group_by() { | e | e }.select() { | k, v | v.size > 1 }.map(&:first).sort
		
		# For each string, remove all characters except those found above (chars in h). 	
		a.each_with_index() { | s, i |	
			a[i] = s.chars.sort.select() { | c |
				h.include?(c)
			}.join
		}
		
		# Return the shortest string left, this asserts we are only counting chars present
		# in all of the input strings, e.g. ["abcd", "abcdefg", "abcdefgh"] => "abcd" is
		# string containing all chars present in ALL of the input strings.
		return a.sort_by() { | s | s.length }[0].length

	else # Solves for a single string in a group, where each character is counted.
		return a[0].length
	end

end

s = ""
c = 0
f = File.readlines('input').each() { | l | 
	if ( l != "\n" && l != nil ) then	
		s += l
	else
		c += get_answer_count(s)
		s = ""
	end
}

puts c
