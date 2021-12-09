class Calculator
  attr_reader :length, :lines, :count

  def initialize(lines)
    @lines = lines
    @count = lines.count.to_f
  end

  def gamma_rate
    sum.map { |f| (f >= @count/2) ? 1 : 0 }.join
  end

  def gamma_rate_decimal
    gamma_rate.to_i(2)
  end

  def epsilon_rate
    sum.map { |f| (f >= @count/2) ? 0 : 1 }.join
  end

  def epsilon_rate_decimal
    epsilon_rate.to_i(2)
  end

  def transpose
    @transpose ||= chars.transpose
  end

  def chars
    @parsed ||= lines.map { |line| line.chars.map(&:to_i) }
  end

  def sum
    transpose.map { |values| values.map(&:to_f).sum }
  end

  def multiplication
    gamma_rate_decimal * epsilon_rate_decimal
  end
end

file = 'input'
lines = File.read(file).split(/\r?\n/)

calc = Calculator.new(lines)
puts calc.multiplication
