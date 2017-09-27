#similar to the board, but with limited functionality
require_relative "board"
class Attack_Grid
  attr_accessor :grid, :cursor_pos, :grid_size
  def initialize(grid_size = 10)
    @grid_size = grid_size
    @grid = default_grid

  end
  def default_grid
    # grid_size = @grid_size

    g = []
    @grid_size.times do
      g << Array.new(grid_size, "O")
    end
    g
  end
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  def set_cursor(pos=[0,0])
    @cursor_pos = pos
    # @grid[pos[0]][pos[1]] = "X"
  end
  def clear_cursor
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        @grid[j][i] = "O" if @grid[j][i] == "X"
      end
    end
  end
  def mark_hit(pos)
    # p @grid[pos[0]][pos[1]]
    @grid[pos[0]][pos[1]] = "H"
  end
  def mark_miss(pos)
    @grid[pos[0]][pos[1]] = "X"
  end
  def render
    # p [""]
    # p @grid

    letters = ("a".."j").to_a
    i = 0
    print "  0 1 2 3 4 5 6 7 8 9\n"
    @grid.each do |row|
      print letters[i] + " "
      j = 0
      row.each do |s|
        ([i,j] == @cursor_pos) ? (print "X ") : (print s + " ")
        # print s + " "
        j += 1
      end
      i += 1
      puts "\n"
    end
  end
end
