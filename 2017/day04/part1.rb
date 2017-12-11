
class Passphrase
  def initialize(name)
    @name = name
    @tokens = name.split(' ')
  end

  def valid?
    while @tokens.any?
      token = @tokens.shift

      return false if @tokens.include?(token)
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