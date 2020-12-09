# Customs declaration
# Individuals in groups answer questions a..z
# Each group is seperated in the input with a newline.
# Each individual is seperated in its group with a trailing newline character.
# Note: This solution required the input to have a newline on its last line instead of an EOF as
#	readlines will cease before we can add the last count - the work around is to accum c with
# 	the output of get_answer_count when we leave the .each(), but that's ugly.

def get_answer_count(inp_str)
	return inp_str.chars.uniq.length
end

s = ""
c = 0
f = File.readlines('input').each() { | l | 
	if ( l != "\n" && l != nil ) then	
		s += l.tr("\n", '')
	else
		c += get_answer_count(s)
		s = ""	
	end
}

puts c
