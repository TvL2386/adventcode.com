require 'fiber'

input = File.read('input').rstrip

array = input.scan(/./).map(&:to_i)

fiber = Fiber.new do
  iter1 = 0
  iter2 = array.length / 2

  while iter1 < array.length
    Fiber.yield iter1, iter2

    iter1 += 1
    iter2 = (iter2 + 1) % array.length
  end
end

sum = 0
while fiber.alive?
  iter1, iter2 = fiber.resume
  break if iter1.nil?

  if array[iter1] == array[iter2]
    sum += array[iter1]
  end
end

puts sum