class Board
  attr_reader :grid
  def initialize(grid = Board.default_grid)
    @grid = grid
  end
  def self.default_grid
    default_size = 10
    g = []
    default_size.times do
      g << Array.new(default_size)
    end
    g
  end
  def count
    count = 0
    @grid.each do |row|
      count += row.count(:s)
    end
    count
  end
  def empty?(pos=false)
    return true if pos && @grid[pos[0]][pos[1]] != :s
    return true if self.count == 0
    false
  end
  def full?
    return true if (self.count == @grid.length**2)
  end
  def won?
    empty?
  end
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  def place_random_ship
    raise "Board is full!" if self.full?
    x = rand(@grid.length)
    y = rand(@grid.length)
    @grid[x][y] = :s
  end

end
