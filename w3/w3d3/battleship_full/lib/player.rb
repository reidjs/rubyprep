require_relative "board"
require 'io/console'
class HumanPlayer
  attr_accessor :name, :board
  def initialize(name, board)
    @name = name
    @board = board
    @ships_to_place = board.SHIPS.keys
  end

  def get_play
    attack = gets.chomp
    x = nil
    y = nil
    attack.chars.each do |c|
      if !(c =~ /\d/).nil?
        x = Integer(c) if x.nil?
        y = Integer(c) if y.nil? && !x.nil?
      end
    end
    if valid_play?(x, y)
      return attack
    else
      get_play
    end
  end
  def valid_play?(x, y)
    x > 0 && x < @board.grid.length
    y > 0 && y < @board.grid.length
  end
  def prompt
    puts "Enter a space to attack: "
  end
  def place_ship_type_prompt
    puts "Enter a ship type: (D)estroyer, (C)ruiser"
    input = gets.downcase.chomp
    ship = :destroyer if input == "d" || input == "destroyer"
    ship = :cruiser if input == "c" || input == "cruiser"
    if !@ships_to_place.include?(ship)
      place_ship_type_prompt
    else
      return ship
    end
  end
  #pos is the top, leftmost position of the ship
  def place_ship_location_prompt(ship, pos)

    size = board.SHIPS[ship]
    x = pos[0]
    y = pos[1]
    board.grid[x][y] = "X"
    board.render
    puts "Use the arrows to move the ship, space to rotate, enter to confirm"
    input = STDIN.getch
    #code from https://gist.github.com/acook/4190379
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    #up
    if input == "\e[A" && x - 1 >= 0
      board.grid[x][y] = nil
      place_ship_location_prompt(ship, [x-1,y])
    elsif input == "\e[B" && x + 1 < board.grid.length
      board.grid[x][y] = nil
      place_ship_location_prompt(ship, [x+1,y])
    elsif input == "\e[C" && y + 1 < board.grid.length
      board.grid[x][y] = nil
      place_ship_location_prompt(ship, [x,y+1])
    elsif input == "\e[D" && y - 1 >= 0
      board.grid[x][y] = nil
      place_ship_location_prompt(ship, [x,y-1])
    elsif input == '\u0003' || input == "\e"
      return false
    else
      place_ship_location_prompt(ship, pos)
    end

  end
  def place_ships
    board.render
    ship = place_ship_type_prompt
    p ship
  end
end
board = Board.new
p1 = HumanPlayer.new("name",board)
# p1.place_ships
p1.place_ship_location_prompt(:destroyer, [0,0])
