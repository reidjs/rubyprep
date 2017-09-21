class BattleshipGame
  attr_reader :board, :player, :computer
  def initialize(player, board)
    @player = player
    @board = board

  end
  def attack(pos)
    @board.grid[pos[0]][pos[1]] = :x
  end
  def count
    @board.send(:count)
  end
  def game_over?
    @board.send(:won?)
  end
  #does this count as hard coding? it didn't specify player input
  def play_turn
    if @player.finished_setting_ships == true
      p "player should attack"
    else
      @player.send(:place_ships)
      # @player.send(:get_play)
      # self.send(:attack, [1,1])
    end
  end
  def place_ships
    @player.send(:place_ships)
end
