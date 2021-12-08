module Day10
  class KnotHash
    def initialize(list:, lengths:)
      @list = create_list(list)
      @lengths = create_list(lengths)

      process
    end

    def ring
      @ring ||= Ring.new(@list)
    end

    def process
      @lengths.each do |length|
        ring.select(length)
        ring.reverse
        ring.forward(length)
      end
    end

    def create_list(string)
      string.split(/,\s+/)
    end

    def result
      ring.slot(0) * ring.slot(1)
    end

    class Ring
      attr_reader :pointer

      def initialize(values)
        @slots = values.dup
        @skip_size = 0
        @pointer = 0
      end

      def select(length)

      end

      def reverse

      end

      def pointer=(value)
/home/tom
      end

      def forward(length)
        steps = @skip_size + length


        @skip_size += 1
      end

      class Slot

      end
    end
  end
end

kh = Day10::KnotHash.new(list: '0,1,2,3,4', lengths: '3,4,1,5')
puts kh.result == 12


