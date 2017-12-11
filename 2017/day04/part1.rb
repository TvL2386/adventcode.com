
class Passphrase
  def initialize(name)
    @name = name
    @tokens = name.split(' ')
    @tokens_tokens = @tokens.map { |token| token.scan(/./).sort }
  end

  def valid?
    while @tokens_tokens.any?
      sorted_chars = @tokens_tokens.shift

      return false if @tokens_tokens.include?(sorted_chars)
    end

    true
  end
end

good = 0

File.read('input').each_line do |line|
  passphrase = Passphrase.new line.rstrip

  if passphrase.valid?
    good += 1
  end
end

puts good