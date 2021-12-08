file = 'input'

previous = nil
puts(File.read(file).split(/\r?\n/).map(&:to_i).select do |current|
  (previous && current > previous).tap { previous = current }
end.count)

