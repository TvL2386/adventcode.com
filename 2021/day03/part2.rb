class Calculator
  attr_reader :length, :lines, :count, :bits

  def initialize(lines)
    @lines = lines
    @count = lines.count.to_f
    @bits = lines.first.length
  end

  def chars
    lines.map { |line| line.chars.map(&:to_i) }
  end

  def find_common(which)
    raise ArgumentError, "Invalid argument #{which.inspect}. Must be :least or :most" unless %i(least most).include?(which)

    relevant = chars

    bits.times do |x|
      transposed = relevant.transpose
      values = transposed[x].compact

      break if values.count == 1

      sum = values.sum.to_f
      mc = (sum / values.count) >= 0.5 ? 1 : 0
      lc = (mc-1).abs

      # remove results no longer relevant
      transposed[x].each_with_index do |val, index|
        if which == :most
          relevant[index].map! { nil } if val != mc

        elsif which == :least
          relevant[index].map! { nil } if val != lc

        else
          raise StandardError, "This should be impossible"
        end
      end
    end

    relevant.each do |values|
      next if values.first.nil?

      return values.join()
    end

    raise StandardError, "I should not get here"
  end

  def oxygen_generator_rating
    find_common(:most).to_i(2)
  end

  def co2_scrubber_rating
    find_common(:least).to_i(2)
  end

  def multiplication
    oxygen_generator_rating * co2_scrubber_rating
  end
end

file = 'input'
lines = File.read(file).split(/\r?\n/)

calc = Calculator.new(lines)
p calc.multiplication
