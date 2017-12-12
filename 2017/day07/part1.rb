module Day07
  class InputParser
    def initialize(file)
      @input_lines = File.read(file).split("\n")

      bake_node_hash
      stitching
    end

    # Example input:
    #   ktlj (57)
    #   fwft (72) -> ktlj
    def bake_node_hash
      @node_hash = Hash.new

      @input_lines.each do |line|
        tokens = line.split(' ')

        # ktlj
        name = tokens.shift

        # (57)
        weight = tokens.shift.scan(/\d+/).first.to_i

        # Do we have references to subnodes?
        children = []

        if tokens.any?
          tokens.shift # discard the arrow
          children = tokens.join.split(',')
        end

        @node_hash[name] = {
          node: Node.new(name, weight),
          children: children
        }
      end
    end

    def stitching
      node_iterator do |node, children|
        children.each do |name|
          node.add_child(@node_hash[name][:node])
        end
      end
    end

    def node_iterator
      @node_hash.values.each do |hash|
        yield hash[:node], hash[:children]
      end
    end
  end

  class Node
    attr_reader :name, :weight, :children

    def initialize(name, weight)
      @name, @weight = name, weight
      @children = []
      @parent = nil
    end

    def add_child(child)
      @children << child.set_parent(self)
    end

    def has_parent?
      !!@parent
    end

    def set_parent(parent)
      @parent = parent
      self
    end
  end
end

parser = Day07::InputParser.new('input')

parser.node_iterator do |node, _|
  unless node.has_parent?
    puts "The root node is: #{node.name}"
    break
  end
end
