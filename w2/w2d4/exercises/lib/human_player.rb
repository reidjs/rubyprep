class HumanPlayer
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def get_move
    puts "where? "
    move = gets.downcase.chomp.chars
    [move.first.to_i, move.last.to_i]
  end
  def display(board)
    p board
  end
end
