require 'byebug'
$bb = false
class Board
  attr_reader :grid
  def initialize(grid=[])
    @grid = grid
    if @grid.empty?
      3.times do
        @grid << [nil,nil,nil]
      end
    end
  end
  #pass location as [x,y], mark as :X or :O
  def place_mark(loc, mark)
    @grid[loc[0]][loc[1]] = mark
  end
  def empty?(loc)
    cell = @grid[loc[0]][loc[1]]
    if cell != :X  && cell != :O
      return true
    end
    false
  end
  def winner_check(arr)
    if arr.uniq.length == 1 && !arr.include?(nil)
      return true
    end
    false
  end

  def winner
    # #rows
    # [0,0] -> [2,0]
    # [0,1] -> [2,1]
    # [0,2] -> [2,2]
    @grid.each do |row|
      #p row
      if winner_check(row)
        return row[0]
      end
    end
    # #cols
    # [0,0] -> [0,2]
    # [1,0] -> [1,2]
    # [2,0] -> [2,2]
    @grid.transpose.each do |col|
      if winner_check(col)
        return col[0]
      end

    end
    # #backslash
    # [2,0] -> [0,2]
    backslash = []
    @grid.each_with_index do |row, j|
      backslash << row[@grid.length - j - 1]
    end
    if winner_check(backslash)
      return backslash[0]
    end
    # #frontslash
    # [0,0] -> [2,2]
    frontslash = []
    @grid.each_with_index do |row, i|
      frontslash << row[i]
    end
    if winner_check(frontslash)
      return frontslash[0]
    end
    return nil
  end
  def over?
    if winner.nil?
      #check for empty spaces
      @grid.flatten.each do |e|
        if e != :X && e != :O
          return false
        end
      end
    end
    true 
  end
end
# def fill_cats_game
#   board = Board.new
#   [[0, 0], [1, 1], [1, 2], [2, 1]].each do |pos|
#     board.place_mark(pos, :O)
#   end
#   [[0, 1], [0, 2], [1, 0], [2, 0], [2, 2]].each do |pos|
#     board.place_mark(pos, :O)
#   end
#   p "Winner: ", board.winner
# end
# fill_cats_game
