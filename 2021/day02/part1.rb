file = 'input'

class Submarine
  def initialize
    @depth = 0
    @horizontal = 0
  end

  def forward(i)
    @horizontal += i
  end

  def up(i)
    @depth -= i
  end

  def down(i)
    @depth += i
  end

  def multiplication
    @depth * @horizontal
  end
end

submarine = Submarine.new

File.read(file).split(/\r?\n/).map do |line|
  tokens = line.split
  action, value = [tokens.first.to_sym, tokens.last.to_i]

  submarine.send(action, value)
end

puts submarine.multiplication



