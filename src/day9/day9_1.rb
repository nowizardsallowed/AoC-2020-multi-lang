file_arr = File.readlines('input').map() { | e | e.to_i }
preamble = file_arr.first(25).sort()
postamble = file_arr.drop(25)
midamble = preamble.length/2

def find_sum(v, i_arr, a)
	s, m = i_arr
	if (s == m) then
		return nil	
	else
		sum = a[s] + a[m]
	end	
	
	# Is a[m] > v? => m--
	#                           V        V  N
	# Seek higher from middle. [0, 1, 2, 3, 4, 5] <= FIND: 2		
	# 
	print a
	puts
	print [a[s], a[m], a[s]+a[m+1], sum, v]
	puts	
	
	if ( a[m] > v || sum > v ) then
		m-=1 
	elsif ( sum == v ) then
		return [a[s], a[m]]
	elsif ( sum < v && a[s] + a[m+1] > v) then
		s+=1
	elsif ( sum < v && a[m+1] < v ) then
		if ( a[m+1] ) then
			puts a[m+1]	
			m+=1
		else
			s+=1
		end	
	end	

	return find_sum(v, [s, m], a)
	
end

# Binary search on preamble to find the sum
for n in postamble
	if !(find_sum(n, [0, midamble], preamble)) then
		puts 'X'
	end 
end

# Compare (m + s) against v and m+1.
# If (m+s) > v and <= n+1, m = m+1. 
# If (m+s) > v and >= n+1, m = m-1
# If (m+s) < v and <= n+1, s = s+1
# If (m+s) < v and >= n+1, m = m-1 
