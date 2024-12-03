require 'debug'

# input = File.readlines('test.txt').map do |line|
input = File.readlines('input.txt').map do |line|
  line.strip.split.map(&:to_i)
end

cols = input.transpose
left = cols.first.sort
right = cols.last.sort

# dists = left.zip(right).map { |l, r| (l-r).abs }
# puts dists.sum


r_tally = right.tally

sims = left.map do |l|
  l * (r_tally[l] || 0)
end
puts sims.sum
