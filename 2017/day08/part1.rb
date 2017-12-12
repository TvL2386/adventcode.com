module Day08
  class InputParser
    def initialize(file)
      @input_lines = File.read(file).split("\n")
    end

    def execute_code
      @variable_store = Hash.new { |h,k| h[k] = 0 }

      @input_lines.each do |line|
        ruby = to_ruby(line)
        eval ruby
      end
    end

    def max_value
      @variable_store.values.max
    end

    def to_ruby(line)
      tokens = line.split(' ')

      new_tokens = []
      new_tokens << to_var(tokens.shift)
      new_tokens << to_oper(tokens.shift)
      new_tokens << tokens.shift
      new_tokens << tokens.shift
      new_tokens << to_var(tokens.shift)
      new_tokens << tokens.shift
      new_tokens << tokens.shift
      new_tokens.join(' ')
    end

    def to_var(string)
      "@variable_store[:#{string}]"
    end

    def to_oper(string)
      case string
        when 'dec'
          '-='
        when 'inc'
          '+='
        else
          raise ArgumentError, "Unknown operator #{string}"
      end
    end
  end
end

parser = Day08::InputParser.new('input')
parser.execute_code
puts parser.max_value