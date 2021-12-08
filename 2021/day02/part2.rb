file = 'input'

class Submarine
  def initialize
    @depth = 0
    @horizontal = 0
    @aim = 0
  end

  def forward(i)
    @horizontal += i
    @depth += @aim*i
  end

  def up(i)
    @aim -= i
  end

  def down(i)
    @aim += i
  end

  def multiplication
    @depth * @horizontal
  end

  def to_s
    { depth: @depth, horizontal: @horizontal, aim: @aim }
  end
end

submarine = Submarine.new

File.read(file).split(/\r?\n/).map do |line|
  tokens = line.split
  action, value = [tokens.first.to_sym, tokens.last.to_i]

  submarine.send(action, value)
end

puts submarine.multiplication



