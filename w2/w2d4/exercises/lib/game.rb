require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board, :current_player, :next_player
  def initialize(player_one, player_two)
    @current_player = player_one
    @next_player = player_two
    @board = Board.new
  end
  def switch_players!
    t = @current_player
    @current_player = @next_player
    @next_player = t
  end
  def play_turn
    @board.place_mark(@current_player.get_move, @current_player.mark)
    self.switch_players!
  end
end
