module Day09
  class Group
    def initialize(string, start_parsing=true, base_score=1)
      @string = string
      @base_score = base_score
      puts "> initializing group:"
      puts "> base score: #{base_score}"
      puts "> string: #{string.inspect}"

      @groups = []

      # Get a char array without first and last char
      # We are a group and don't need { ... }
      # surrounding us

      @chars = []
      if string.length > 0
        @chars = string.scan(/./)[1...-1]
      end

      parse if start_parsing
    end

    def parse
      ignore_next = false
      garbage = false

      # group openers found
      group_openers = 0

      buffer = []

      while @chars.any?
        char = @chars.shift
        buffer << char

        if ignore_next
          ignore_next = false
          next
        end

        case char
          when '!'
            ignore_next = true

          when '{'
            next if garbage
            group_openers += 1

          when '}'
            next if garbage

            group_openers -= 1

            next if group_openers > 0

            @groups << Group.new(buffer.join, false, @base_score+1)
            buffer.clear

            # If next char is a comma, shift it into oblivion
            # Because we don't want to retain this group separator
            @chars.shift if @chars.first == ','

          when '<'
            garbage = true

          when '>'
            garbage = false

        end
      end

      @groups.map(&:parse)
    end

    def score
      sum = @base_score

      if @groups.any?
        sum += @groups.map(&:score).inject(:+)
      end

      sum
    end

    def to_s
      "score: #{score} - sequence: #{@string.inspect}"
    end
  end
end

# puts Day09::Group.new('{}').score == 1
# puts Day09::Group.new('{{{}}}').score == 6
# puts Day09::Group.new('{{},{}}').score == 5
# puts Day09::Group.new('{{{},{},{{}}}}').score == 16
# puts Day09::Group.new('{<a>,<a>,<a>,<a>}').score == 1
# puts Day09::Group.new('{{<ab>},{<ab>},{<ab>},{<ab>}}').score == 9
# puts Day09::Group.new('{{<!!>},{<!!>},{<!!>},{<!!>}}').score == 9
# puts Day09::Group.new('{{<a!>},{<a!>},{<a!>},{<ab>}}').score == 3
#
# puts Day09::Group.new('{<a!!!!>}').score == 1
# puts Day09::Group.new('{<a>,<a!>,<a>,<a>}').score == 1
puts Day09::Group.new('{{<!>,<!>},<ieo!e>},{{<e!>,<''!>,<<ia!i>}}}').score == 8

puts Day09::Group.new(File.read('input')).score
