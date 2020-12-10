# Handy Haversacks
# Part TWO: Find the number of bags within a shiny gold bag in total.
# Factorial problem, e.g. gold [1] => blue [3] => yellow [2] => red [5] 
# is 1*3*2*5 bags total.

bag_arr = File.read('input').split("\n")
# Split the strings into a hash, remove redundant "bags contain" line.
bag_hash = Hash[bag_arr.map() { | e | e.split(" bags contain ") }]
# Trim down the strings that will eventually be the hash values.
bag_hash = bag_hash.transform_values() { | v | 
	v.tr(".,", "").gsub(/\s?bags?/,"")
}
# Create a multi-tiered hash table where each value is now a hash with a value
#	equal to the number of bags of that colour (key).
bag_hash.each() { | k, v |
	new_values = v.scan(/[0-9]/)
	new_keys = v.split(/\s?[0-9]\s?/).drop(1)
	new_hash = Hash[new_keys.each_with_index.map() { | s, i |
		[s, new_values[i].to_i]
	}]
	bag_hash[k] = new_hash
}

# Store bag colour and number in a md array.
# Traverse through the hash table storing bag colour, bag accumulator in the
#	bags_to_check array.
bags_to_check = [["shiny gold", 1]]
total_count = 0

while bags_to_check.length > 0
	bag = bags_to_check.shift
	check_arr = bag_hash[bag.first]
	outer_count = bag.last
	check_arr.each { | b | 
		total_count += (outer_count * b.last)
		bags_to_check.append([b.first, (outer_count * b.last)])
	}
end

puts total_count
