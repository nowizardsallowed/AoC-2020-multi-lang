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
# Get answer by parsing through hash to find keys that include the current key.
# Definitely not the most efficient answer. 

def solve(inp_str, bag_hash)
	return bag_hash.select{ | k, v | v.include?(inp_str)}
end

bag_arr = File.read('input').split("\n")
bag_hash = Hash[bag_arr.map() { | e | e.split(" bags contain ") }]
bag_hash = bag_hash.transform_values() { | v | 
	v.tr(".,", "").gsub(/\s?bags?/,"").split(/\s?[0-9]\s/).drop(1)
}

bags_checked = []
bags_to_check = ["shiny gold"]

while bags_to_check.any?
	check_bag = bags_to_check.shift
	solve(check_bag, bag_hash).each do | p |		
		bags_checked.append(p[0])
		bags_to_check.append(p[0])	
	end
end

puts bags_checked.uniq.length
