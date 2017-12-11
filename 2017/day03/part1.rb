class Grid
  def initialize(value)
    resize_to(value)
  end

  def steps_to(value)
    0
  end

  # private

  def locations
    @locations ||= []
  end

  def hash
    @hash ||= {}
  end

  def resize_to(value)
    x,y=0,0


    1.upto(value) do |c|
      hash[c] = 1.abs
    end

  end
end

class Grid
  class Location
    attr_reader :x, :y, :value

    def initialize(x, y, value)
      @x, @y, @value = x, y, value
    end
  end
end

# grid = Grid.new(25)
# p grid.locations
# puts(grid.steps_to(12) == 3)
# puts(grid.steps_to(1) == 0)
# puts(grid.steps_to(23) == 2)
# puts(grid.steps_to(1024) == 31)
#
# #puts grid.steps_to(368078)
# puts grid.steps_to(1024)

fiber = Fiber.new do
  layer = 1
  width = 1
  max_distance = 0
  min_distance = 0
  distance = 0
  direction = :up

  loop do
    items = (layer == 1) ? 1 : (width*width - (width-2)*(width-2))

    # puts "\n>>> starting layer: #{layer} items: #{items} - (min_distance: #{min_distance} max_distance: #{max_distance} distance_value: #{distance}) <<<"


    items.times do |i|
      # puts"layer: #{layer} width: #{width} distance: #{distance}"
      Fiber.yield distance

      if distance == min_distance
        direction = :up
      elsif distance == max_distance
        direction = :down
      end

      case direction
        when :up
          distance += 1
        when :down
          distance -= 1
      end

      if distance == 0
        distance += 1
      end
    end

    layer += 1
    width += 2

    min_distance +=1
    max_distance = (layer-1)*2

    if layer > 1
      direction = :down
      distance = max_distance -1
    end
  end
end

# grid = Grid.new(25)
# p grid.locations
# puts(grid.steps_to(12) == 3)
# puts(grid.steps_to(1) == 0)
# puts(grid.steps_to(23) == 2)
# puts(grid.steps_to(1024) == 31)
#
# #puts grid.steps_to(368078)
# puts grid.steps_to(1024)

max = 368078
distance_hash = Hash.new
1.upto(max) do |x|
  distance_hash[x] = fiber.resume
end

puts distance_hash[12]
puts distance_hash[1]
puts distance_hash[23]
puts distance_hash[1024]
puts distance_hash[368078]

# 1 => 0,0     1
#
# 2 => 1,0     9-1=8
# 3 => 1,1
# 4 => 0,1
# 5 => -1,1
# 6 => -1,0
# 7 => -1,-1
# 8 => 0,-1
# 9 => 1,-1
#
# 10 => 2,-1   25-9=16
# 11 => 2,0
# 12 => 2,1
# 13 => 2,2
# 14 => 1,2
# 15 => 0,2
# 16 => -1,2
# 17 => -2,2
# 18 => -2,1
# 20 => -2,-1
# 21 => -2,-2
# 22 => -1,-2
# 23 => 0,-2
# 24 => 1,-2
# 25 => 2,-2
#
# 26 => 3,-2    7*7 - 5*5 = 24
# ..
# 50 => 3,-3