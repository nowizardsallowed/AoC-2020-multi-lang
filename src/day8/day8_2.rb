# Handheld halting
# Run the instruction, store the line, if we've visited the line before, we exit
# 	and puts the accumulator.
# Easy peasy.
# This is (obviously) limited by the size of the file and would be better with an
#	fseek-style approach.	


def solve(line_arr)
	change_arr = line_arr.clone.map(&:clone)

	for n in 0..line_arr.length
		if (line_arr[n] == nil) then
			return nil		
		end
		if line_arr[n][0] != "acc" then
			line_arr[n][0] = (change_arr[n][0] == "nop") ? "jmp" : "nop"
			parsed = parse(line_arr)
			if (parsed[0]) then
				return change_arr[n]
			else
				print [line_arr[n], change_arr[n], parsed]
				puts
				line_arr[n] = change_arr[n]
			end
		end	
	end
end

def parse(line_arr)
	lines_visited = []
	accum = 0
	curr_line = 0
	instr = {
		"acc" => -> (x) { accum += x
			  curr_line += 1			
			},
		"jmp" => -> (x) { curr_line += x },
		"nop" => -> (x) { curr_line += 1 }
	}

	for n in 0..line_arr.length
		n = curr_line		
		if (lines_visited.include?(n)) then
			return false, accum
		end
		
		i, a = line_arr[n]
		lines_visited.append(n)
		instr[i].call(a.to_i)
		prev_line = n
	end
	
	return true, accum
end

f = File.readlines('input').map() { | l | l.split(" ") }
solve(f)
# Parse through the input, if an instruction is a jmp, switch it to a nop - vice versa. 
# Save the index of the changed line and continue executing (parse).
# If parse returns nothing, change back the instruction and parse until the next nop/
# jmp instruction change.

