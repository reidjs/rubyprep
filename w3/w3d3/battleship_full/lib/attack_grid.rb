#similar to the board, but with limited functionality
require_relative "board"
class Attack_Grid
  attr_accessor :grid, :cursor_pos
  def initialize(grid = Attack_Grid.default_grid)
    @grid = grid
  end
  def self.default_grid
    default_size = 10
    g = []
    default_size.times do
      g << Array.new(default_size, "O")
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
  def mark_success(boat, pos)
    p @grid[pos[0]][pos[1]]
    @grid[pos[0]][pos[1]] = "S"
  end
  def mark_fail(pos)
    @grid[pos[0]][pos[1]] = "F"
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
