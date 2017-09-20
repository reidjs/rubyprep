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
    puts "Enter a ship type: (D)estroyer [DD], (C)ruiser [CC]"
    input = gets.downcase.chomp
    ship = :destroyer if input == "d" || input == "destroyer"
    ship = :cruiser if input == "c" || input == "cruiser"
    if !@ships_to_place.include?(ship)
      place_ship_type_prompt
    else
      return ship
    end
  end
  def get_array_of_spaces_taken_by_ship(ship, pos, rot)
    x = pos[0]
    y = pos[1]
    size = @board.SHIPS[ship]
    rot == "vertical" ? x2 = x + size : x2 = x
    rot == "horizontal" ? y2 = y + size : y2 = y
    # p "sposition: #{pos}, eposition: #{[y2, x2]}"
    # render_ship_on_board(ship, @board.traverse(pos, [x2, y2]))
    @board.traverse(pos, [x2, y2])
  end
  #pos is the top, leftmost position of the ship
  def place_ship_location_prompt(ship, pos, rot="vertical")
    @board.clear_temp_spaces
    spaces = get_array_of_spaces_taken_by_ship(ship, pos, rot)
    render_ship_on_board(ship, spaces)
    puts "Use the arrows to move the ship, space to rotate, enter to confirm"
    #get input from the player
    input = STDIN.getch
    handle_player_input(input, ship, pos, rot)
    # move_ship_on_board(input, @board.traverse())
  end
  #send in array of positions occupied by the ship
  def render_ship_on_board(ship, arr)
    # p arr
    arr.each do |e|
      if @board.empty?([e[0], e[1]])
        @board.grid[e[0]][e[1]] = "X"
      end
    end
    @board.render
  end
  def handle_player_input(input, ship, pos, rot)
    x = pos[0]
    y = pos[1]
    size = board.SHIPS[ship]
    rot == "vertical" ? xsize = size : xsize = 0
    rot == "horizontal" ? ysize = size : ysize = 0
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    #code from https://gist.github.com/acook/4190379
    if input == "\e[A" && x > 0
      x -= 1
    elsif input == "\e[B" && x + xsize < (board.grid.length - 1)
      x += 1
    elsif input == "\e[C" && y+ysize < (board.grid.length - 1)
      y += 1
    elsif input == "\e[D" && y > 0
      y -= 1
    elsif input == " "
      if rot == "vertical"
        y = y - size  if y + size > (@board.grid.length - 1)
        rot = "horizontal"
      else
        rot = "vertical"
      end
    elsif input == '\u0003' || input == "\e"
      return false
    elsif input == "\r"
      place_ships if place_ship_at_location(ship, pos, rot)
      # place_ships if @ships_to_place.length > 0
    end
    p "in: #{input}, x: #{x}, y: #{y}, size:#{size}, rot: #{rot}"
    place_ship_location_prompt(ship, [x, y], rot)
  end
  def place_ship_at_location(ship, pos, rot)
    spaces = get_array_of_spaces_taken_by_ship(ship, pos, rot)
    spaces.each do |e|
      p "#{e}, empty? #{@board.empty?(e)}"
    end
    false
  end
  def place_ships
    board.render
    ship = place_ship_type_prompt
    p ship
  end
end
board = Board.new
board.grid[1][1] = :BB
p1 = HumanPlayer.new("name",board)
# p1.place_ships
p1.place_ship_location_prompt(:DD, [0,0])
