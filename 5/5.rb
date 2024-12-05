require 'debug'

# s1, s2 = File.read('test.txt').split("\n\n").map { |s| s.split("\n") }
s1, s2 = File.read('input.txt').split("\n\n").map { |s| s.split("\n") }

rules = s1.each_with_object({}) do |rule, hash|
  n1, n2 = rule.split('|').map(&:to_i)
  hash[n1] ||= []
  hash[n1] << n2
end

sections = s2.map { |sec| sec.split(',').map(&:to_i) }

invalid_secs = []

valid_secs = sections.map do |sec|
  ordered = sec.map.with_index do |num, index|
    rules[num].nil? || rules[num].map do |later_num|
      indexes = sec.each_index.select { |i| sec[i] == later_num }.uniq
      debugger if indexes.count > 1

      later_index = indexes.first
      later_index.nil? || later_index > index
    end.all? { |r| r }
  end

  invalid_secs << sec && next if ordered.any? { |o| !o }
  sec
end.compact

# puts valid_secs.sum { |vs| vs[vs.length/2] }

# fixed_secs = [invalid_secs.last].map do |sec|
fixed_secs = invalid_secs.map do |sec|
  new_sec = sec.dup

  while true
    finished = true
    
    new_sec.each.with_index do |num, index|
      after_nums = rules[num]
      next if after_nums.nil?

      least_index = new_sec.each_index.select { |i| after_nums.include?(new_sec[i]) }.min
      next if least_index.nil?

      if least_index < index
        new_sec.insert(least_index, new_sec.delete_at(index))
        finished = false
        break
      end
    end
    # debugger
    break if finished == true
  end

  new_sec
end

puts fixed_secs.sum { |vs| vs[vs.length/2] }
# debugger
