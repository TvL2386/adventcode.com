class World
  def initialize
    @tiles = Array.new
    @tiles << Tile.new(world: self)

    # This is a hash for easy lookupks if a tile already exists
    # By checking @coordinates[x][y] we can get that tile or nil
    @coordinates = Hash.new do |h, k|
      h[k] = Hash.new
    end

    add_tile_to_lookup_table(@tiles.first)
  end

  def tiles
    @tiles
  end

  def tile(number)
    (number - @tiles.length).times do
      increase_tiles
    end

    @tiles[number-1]
  end

  def has_tile?(coordinates)
    !!tile_at(coordinates)
  end

  def tile_at(coordinates)
    @coordinates[coordinates.x][coordinates.y]
  end

  def increase_tiles
    next_tile = @tiles.last.next
    @tiles << next_tile

    add_tile_to_lookup_table next_tile
  end

  def add_tile_to_lookup_table(tile)
    @coordinates[tile.coordinates.x][tile.coordinates.y] = tile
  end

  def get_tiles_surrounding(coordinates)
    tiles = Array.new
    tiles << tile_at(coordinates.right)
    tiles << tile_at(coordinates.right.up)
    tiles << tile_at(coordinates.up)
    tiles << tile_at(coordinates.left.up)
    tiles << tile_at(coordinates.left)
    tiles << tile_at(coordinates.left.down)
    tiles << tile_at(coordinates.down)
    tiles << tile_at(coordinates.down.right)
    tiles.compact
  end
end

class World
  class Tile
    attr_reader :value

    NEW_DIRECTION = {
      right: :up,
      up: :left,
      left: :down,
      down: :right
    }

    def initialize(world:, direction: :right, x: 0, y: 0, value: 1)
      @value = value
      @world = world
      @direction = direction
      @x = x
      @y = y
    end

    def distance
      @x.abs + @y.abs
    end

    def next
      new_direction = NEW_DIRECTION[@direction]
      new_coordinates = next_coordinates(new_direction)

      # If the world already has a tile in the new direction
      # we continue on the original path
      if @world.has_tile?(new_coordinates)
        new_direction = @direction
        new_coordinates = next_coordinates(new_direction)
      end

      tiles = @world.get_tiles_surrounding(new_coordinates)
      value = tiles.map(&:value).inject(:+)

      Tile.new world: @world, direction: new_direction, x: new_coordinates.x, y: new_coordinates.y, value: value
    end

    def next_coordinates(direction)
      case direction
        when :right
          return coordinates.right
        when :up
          return coordinates.up
        when :left
          return coordinates.left
        when :down
          return coordinates.down
      end
    end

    def coordinates
      @coordinates ||= Coordinates.new(@x,@y)
    end
  end

  class Coordinates
    attr_reader :x, :y

    def initialize(x,y)
      @x,@y=x,y
    end

    def right
      Coordinates.new(@x+1,@y)
    end

    def up
      Coordinates.new(@x,@y+1)
    end

    def left
      Coordinates.new(@x-1,@y)
    end

    def down
      Coordinates.new(@x,@y-1)
    end
  end
end

world = World.new

x = 1
loop do
  if world.tile(x).value > 368078
    puts world.tile(x).value
    break
  end

  x += 1
end