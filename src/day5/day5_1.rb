# Binary seating:
# 7 chars of either F or B which dictate which half of the current selection 
# we need to search in (e.g. 0-127: F is 0-63, B is 64-127).
# Last three characters are either L or R, telling us where to select in
# the last eight characters (e.g. 0-8: L is 0-3, R is 4-7).
# The above process gives you the row and the column, multiply these to get the 
# seat ID.

# FIND THE HIGHEST SEAT ID
# Will be mostly B's.

def halve(inp_arr, dir)
  round_dir = (dir.zero?) ? :down : :up
  red = ((inp_arr[1] - inp_arr[0]).to_f/2).round(half: round_dir)
  inp_arr[dir] = inp_arr[1] - red
  return inp_arr
end

f = File.open('input')
max_id = 0

while ( true ) do
  seat = [[0, 127], [0, 7]]

  s = f.gets
  if ( !s ) then
    puts max_id
    return
  end
  s = s.chars().first(10).join
 
  s.chars().first(7).each() { | c |
    # If regex fails (nil), we're editing the bottom half (arr[1]).
    b = (c =~ /B/) ? 0 : 1
    seat[0] = halve(seat[0], b)
  }

  s.chars().last(3).each() { | c |
    b = (c =~ /R/) ? 0 : 1
    seat[1] = halve(seat[1], b)
  }

  id = (seat[0][0] * 8) + seat[1][0]
  if ( id > max_id ) then
    max_id = id
  end
end
