input = File.read('input').rstrip

if input.length == 0
  puts 0
  exit 0
else
  sum = 0

  array = input.scan(/./).map(&:to_i)
  array.each_index do |i|
    current = array[i]

    if (i+1) == array.length
      peek = array.first
    else
      peek = array[i+1]
    end

    sum += current if(current == peek)
  end

  puts sum
end