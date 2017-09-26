require "byebug"
class ComputerPlayer
  attr_reader :name, :board
  attr_accessor :mark
  def initialize(name)
    @name = name
  end
  def display(board)
    @board = board
  end
  def win_check(arr)
    p arr
    if !@mark.nil? && arr.count(@mark) >= @board.grid.length - 1
      #play this row
      return true
    end
    false
  end
  #random unless a winning move is available
  def get_move
    winning_move = false
    winning_row = -1
    winning_col = -1
    #look for two in a row
    @board.grid.each_with_index do |row, i|
      if win_check(row)
        # p "should play row:", i
        winning_row = i
        winning_col = row.index(nil)
        # p row
        winning_move = true
      end
    end
    @board.grid.transpose.each_with_index do |col, i|
      if win_check(col)
        # p "should play col:", @board.grid.length - i - 1
        winning_row = col.index(nil)
        # winning_col = @board.grid.length - i - 1
        winning_col = i
        # p "row: #{winning_row}, col: #{winning_col}"
        winning_move = true
      end
    end
    backslash = []
    @board.grid.each_with_index do |row, j|
      backslash << row[@board.grid.length - j - 1]

    end
    if win_check(backslash)
      p "should play diag:"
      # p backslash
      winning_move = true
    end
    frontslash = []
    @board.grid.each_with_index do |row, i|
      frontslash << row[i]
    end
    if win_check(frontslash)
      p "should play diag:"
      # p frontslash
      winning_move = true
    end
    # byebug
    if winning_move
      p "There is a winning move"
      [winning_row, winning_col]
    else
      [rand(@board.grid.length), rand(@board.grid.length)]
    end
  end
end
