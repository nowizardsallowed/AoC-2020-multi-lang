# Handheld halting
# Parse through the list of instructions, change all nops to jmps, and vice versa.
# For each change, try to solve the instruction set (run each instruction).
# If the instruction set loops back on itself (reaches an instruction that has 
#	previously been executed), return false.
# Otherwise, return the accumulator and find our answer.

def solve(line_arr)
	change_arr = line_arr.clone.map(&:clone)

	for n in 0..line_arr.length
		if !(line_arr[n]) then
			return nil		
		end
		if line_arr[n][0] != "acc" then
			line_arr[n][0] = (change_arr[n][0] == "nop") ? "jmp" : "nop"

			if ((parsed = parse(line_arr))) then
				return parsed
			else
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
	
	while !(lines_visited.include?(curr_line))
		if ( curr_line == line_arr.length ) then
			return accum
		else		
			lines_visited.append(curr_line)
			i, a  = line_arr[curr_line]
			instr[i].call(a.to_i)
		end
	end
	
	return false
end

f = File.readlines('input').map() { | l | l.split(" ") }
puts solve(f)
