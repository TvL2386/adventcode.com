require 'pry'

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

    def total_weight
      sum = weight

      if children.any?
        sum += children.map(&:total_weight).inject(:+)
      end

      sum
    end

    def has_parent?
      !!@parent
    end

    def set_parent(parent)
      @parent = parent
      self
    end

    def balanced?
      children.map(&:total_weight).uniq.length == 1
    end

    # We need to look at child total_weight
    # And find the child with a weight that is
    # different from the other children
    def unbalanced_child
      h = Hash.new { |h,k| h[k] = [] }

      total_weights = []

      children.each do |child|
        h[child.total_weight] << child
        total_weights << child.total_weight

        # puts "child.name: #{child.name} child.total_weight: #{child.total_weight}"
      end

      total_weights.uniq!
      # p total_weights

      h.each do |weight, children|
        if children.count == 1
          # We found the child that has the wrong weight
          child = children.first

          # Determine the weight it should have
          should_have_weight = (total_weights - [child.total_weight]).first
          # puts "Child #{child.name} has incorrect total_weight. It should be #{should_have_weight}"

          return child, should_have_weight
        end
      end

      nil
    end
  end
end

parser = Day07::InputParser.new('input')

root_node = nil
parser.node_iterator do |node, _|
  unless node.has_parent?
    root_node = node
    puts "The root node is: #{node.name}"
    break
  end
end

if root_node.balanced?
  puts 'Root node is balanced!'
else
  loop do
    root_node, should_have_weight = root_node.unbalanced_child

    if root_node.balanced?
      puts "First balanced node found: #{root_node.name}"
      puts "Its total_weight is #{root_node.total_weight} but should be #{should_have_weight}"

      weight_increase = should_have_weight - root_node.total_weight
      puts "Its weight should be: #{root_node.weight + weight_increase}"

      break
    end
  end
end
