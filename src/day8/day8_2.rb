# Handheld halting
# Run the instruction, store the line, if we've visited the line before, we exit
# 	and puts the accumulator.
# Easy peasy.
# This is (obviously) limited by the size of the file and would be better with an
#	fseek-style approach.	

accum = 0
prev_line = 0
curr_line = 0
lines_visited = []

instr = {
	"acc" => -> (x) { accum += x
			  curr_line += 1			
			},
	"jmp" => -> (x) { curr_line += x },
	"nop" => -> (x) { curr_line += 1 }
}

f = File.readlines('input')

for n in 0..f.length
	n = curr_line

	if !(f[n]) || (lines_visited.include?(n)) then
		# Revert to previous line:
		n = prev_line 
		# Get and check instruction, if it's a nop we change it to a jump
		# 	if its a jump, we change it to a nop.
		# This is a bit of a divide and conquer approach though, not sure
		# 	we want to solve it this way.	
		exit
	end

	i, a = f[n].split(" ")
	instr[i].call(a.to_i)
	lines_visited.append(n)
	prev_line = n
end

# Perhaps collecting all the changed instructions (nops to jmps and vice versa) and
#	printing this on termination might be helpful here - we don't _technically_
#	have to solve this purely with an algorithm.
