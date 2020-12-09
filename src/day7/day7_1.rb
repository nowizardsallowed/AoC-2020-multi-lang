# Handy Haversacks
# Bags need to be colour-coded and contain multiple (also colour-coded) bags.
# Input is a rule-set dictating what bags can contain what (including other bags).
# Group the list of strings into a hash:
#	crimson =>
#		vibrant => [blue, drab]
# 		...
#		shiny => 
#	blue =>
#		drab => [aqua, dark]
#		...
#	aqua =>
#		dark => [[maroon, pale], [gray, dotted], [plum, muted], [orange, muted]]
#		...
#	etc.
# Answer is each bag 

bag_count = 0

def solve(inp_str, bag_hash)
	r = bag_hash.select{ | k, v | v.include?(inp_str)}
	bag_count += r.length

	if ( r.length <= 0 ) then
		return 0
	else
		print r, r.length
		puts	
		puts bag_count
		puts " --- "
		puts 
		return r.map() { | k,v | 
			solve(k, bag_hash)
		}
	end
end

bag_arr = File.read('input').split("\n")
bag_hash = Hash[bag_arr.map() { | e | e.split(" bags contain ") }]
bag_hash = bag_hash.transform_values() { | v | 
	v.tr(".,", "").gsub(/\s?bags?/,"").split(/\s?[0-9]\s/).drop(1)
}

c = solve("shiny gold", bag_hash)
puts c
