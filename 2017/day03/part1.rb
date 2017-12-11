
fiber = Fiber.new do
  layer = 1
  width = 1
  max_distance = 0
  min_distance = 0
  distance = 0
  direction = :up

  loop do
    items = (layer == 1) ? 1 : (width*width - (width-2)*(width-2))

    items.times do |i|
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
