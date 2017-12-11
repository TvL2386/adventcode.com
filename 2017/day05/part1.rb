module CPU
  class Stack
    attr_reader :instructions_executed

    def initialize(jumps)
      @jumps = jumps.map { |i| Jump.new(i) }
      @ptr = 0
      @instructions_executed = 0
    end

    def execute
      jump = @jumps[@ptr]

      while !jump.nil? do
        # print_current_stack

        @ptr += jump.execute
        jump = @jumps[@ptr]
        @instructions_executed += 1
      end
    end

    def print_current_stack
      @jumps.each_index do |index|
        if index == @ptr
          print "(#{@jumps[index].instruction}) "
        else
          print "#{@jumps[index].instruction} "
        end
      end
      puts
    end
  end

  class Jump
    attr_reader :instruction

    def initialize(instruction)
      @instruction = instruction
    end

    def execute
      retval = @instruction
      @instruction += 1
      retval
    end
  end
end

input = File.read('input').split("\n").map(&:to_i)
#input = %w[0 3 0 1 -3].map(&:to_i)
stack = CPU::Stack.new(input)
stack.execute
puts stack.instructions_executed