require 'debug'

# input = File.readlines('test.txt').map do |line|
input = File.readlines('input.txt').map do |line|
  line.strip.split.map(&:to_i)
end

def safe_rate?(arr)
  vels = arr.each_cons(2).map do |n1, n2|
    n2 - n1
  end

  same_rate = vels.all? { |v| v.positive? } || vels.all? { |v| v.negative? }
  slow_rate = vels.all? { |v| v != 0 && v.abs <= 3 }

  return same_rate && slow_rate
end

def do_the_thing(arr)
  orig_safe = safe_rate?(arr)
  return true if orig_safe
  
  tol_arrs = (0...arr.size).map do |i|
    arr.reject.with_index { |_, index| index == i }
  end

  tol_arrs.any? { |a| safe_rate?(a) == true }
end

safe_arr = input.map { |arr| do_the_thing(arr) }
# puts safe_arr.inspect
puts safe_arr.select { |v| v == true }.count

# vel_arr = input.map do |nums|
  # nums.each_cons(2).map do |n1, n2|
  #   n2 - n1
  # end
# end

# count = 0
# vel_arr.each do |vels|
#   safe_rate = vels.all? { |v| v.positive? } || vels.all? { |v| v.negative? }
#   slow_rate = vels.all? { |v| v != 0 && v.abs <= 3 }
#   if (safe_rate && slow_rate)
#     count += 1
#   end
# end

# vel_arr.each do |vels|

#   pos_arr = vels.map do |v|
#     v.positive? && v <= 3
#   end

#   neg_arr = vels.map do |v|
#     v.negative? && v >= -3
#   end

#   puts "#{vels}: pos_arr:#{pos_arr}, neg_arr:#{neg_arr}"

# end

# puts count