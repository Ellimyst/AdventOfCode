require 'debug'

input = File.read('test2.txt')
input = File.read('input.txt')

# instr = input.scan(/mul\((\d{1,3})\,(\d{1,3})\)/).map { |x,y| [x.to_i, y.to_i] }
# puts instr.inspect
# results = instr.map { |x,y| x*y }
# puts results.sum


instr = input.scan(/mul\(\d{1,3}\,\d{1,3}\)|do\(\)|don\'t\(\)/)
# puts instr.inspect

enabled = true
results = instr.map do |i|
  case i
  when 'do()'
    enabled = true
    0
  when "don't()"
    enabled = false
    0
  when /mul\((\d{1,3})\,(\d{1,3})\)/
    x = $1.to_i
    y = $2.to_i
    enabled ? x * y : 0
  else
    puts 'error!'
  end
end
puts results.sum

