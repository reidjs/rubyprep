#similar to the board, but with limited functionality
require_relative "board"
class Attack_Grid
  attr_accessor :grid
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
  def render
    # p [""]
    letters = ("a".."j").to_a
    i = 0
    print "  0 1 2 3 4 5 6 7 8 9\n"
    @grid.each do |row|
      print letters[i] + " "
      row.each do |s|
        print s + " "
      end
      i += 1
      puts "\n"
    end
  end
end
