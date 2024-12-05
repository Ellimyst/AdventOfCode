require 'debug'

# input = File.readlines('test.txt').map do |line|
input = File.readlines('input.txt').map do |line|
  line.strip.split('')
end

len = 4-1
str = 'XMAS'

@yl = input.length
@xl = begin
  l = input.map(&:length).uniq
  l.count == 1 ? l.first : raise('differnt lengths')
end

def bounds?(xv, yv, x, y)
  xb = xv.zero? ? true : ( xv.positive? ? ((x+3) < @xl) : ((x-3) >= 0) )
  yb = yv.zero? ? true : ( yv.positive? ? ((y+3) < @yl) : ((y-3) >= 0) )

  xb && yb
end

top = lambda do |x, y|
  return false unless bounds?(0, -1, x, y)
  [input[y][x], input[y-1][x], input[y-2][x], input[y-3][x]].join('')
end

bot = lambda do |x, y|
  return false unless bounds?(0, 1, x, y)
  [input[y][x], input[y+1][x], input[y+2][x], input[y+3][x]].join('')
end

left = lambda do |x, y|
  return false unless bounds?(-1, 0, x, y)
  [input[y][x], input[y][x-1], input[y][x-2], input[y][x-3]].join('')
end

right = lambda do |x, y|
  return false unless bounds?(1, 0, x, y)
  [input[y][x], input[y][x+1], input[y][x+2], input[y][x+3]].join('')
end

top_left = lambda do |x, y|
  return false unless bounds?(-1, -1, x, y)
  [input[y][x], input[y-1][x-1], input[y-2][x-2], input[y-3][x-3]].join('')
end

top_right = lambda do |x, y|
  return false unless bounds?(1, -1, x, y)
  [input[y][x], input[y-1][x+1], input[y-2][x+2], input[y-3][x+3]].join('')
end

bot_left = lambda do |x, y|
  return false unless bounds?(-1, 1, x, y)
  [input[y][x], input[y+1][x-1], input[y+2][x-2], input[y+3][x-3]].join('')
end

bot_right = lambda do |x, y|
  return false unless bounds?(1, 1, x, y)
  [input[y][x], input[y+1][x+1], input[y+2][x+2], input[y+3][x+3]].join('')
end

count = 0
# (0..@yl-1).each do |y|
#   (0..@xl-1).each do |x|
#     [top, bot, left, right, top_left, top_right, bot_left, bot_right].each do |func|
#       # out = func.call(x, y)
#       # if out == str
#       #   count += 1
#       # else
#       #   puts "#{out}: #{x+1},#{y+1}"
#       # end

#       if func.call(x, y) == str
#         count += 1
#       end
#     end
#   end
# end

@input = input
def do_the_thing(x, y)
  # debugger
  slice = @input[y..y+2].map { |r| r[x..x+2] }.flatten.join('')

  regexes = [
    /S.S.A.M.M/,
    /S.M.A.S.M/,
    /M.M.A.S.S/,
    /M.S.A.M.S/
  ]

  regexes.any? { |r| slice.match?(r) }
end

(0..@yl-3).each do |y|
  (0..@xl-3).each do |x|
    if do_the_thing(x, y)
      count += 1
    end
  end
end

puts count
# debugger
