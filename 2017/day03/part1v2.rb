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
    @coordinates[coordinates[0]][coordinates[1]]
  end

  def increase_tiles
    next_tile = @tiles.last.next
    @tiles << next_tile

    add_tile_to_lookup_table next_tile
  end

  def add_tile_to_lookup_table(tile)
    @coordinates[tile.x][tile.y] = tile
  end
end

class World
  class Tile
    attr_reader :x, :y

    NEW_DIRECTION = {
      right: :up,
      up: :left,
      left: :down,
      down: :right
    }

    def initialize(world:, direction: :right, x: 0, y: 0)
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

      Tile.new world: @world, direction: new_direction, x: new_coordinates[0], y: new_coordinates[1]
    end

    def next_coordinates(direction)
      coordinates.send(direction)
    end

    def coordinates
      [@x,@y]
    end
  end
end

world = World.new
puts world.tile(12).distance
puts world.tile(1).distance
puts world.tile(23).distance
puts world.tile(1024).distance
puts world.tile(368078).distance
