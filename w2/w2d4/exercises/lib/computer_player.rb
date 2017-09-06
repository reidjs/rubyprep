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
    #look for two in a row
    @board.grid.each_with_index do |row, i|
      if win_check(row)
        p "should play row:", i
      end
    end
    @board.grid.transpose.each_with_index do |col, i|
      if win_check(col)
        p "should play col:", @board.grid.length - i - 1
      end
    end
    backslash = []
    @board.grid.each_with_index do |row, j|
      backslash << row[@board.grid.length - j - 1]
    end
    if win_check(backslash)
      p "should play diag:"
    end
    frontslash = []
    @board.grid.each_with_index do |row, i|
      frontslash << row[i]
    end
    if win_check(frontslash)
      p "should play diag:"
    end
    [rand(@board.grid.length), rand(@board.grid.length)]
  end
end
