require_relative "board"
require_relative "attack_grid"
require 'io/console'
class Player
  # attr_accessor :ships_to_place, :board
  attr_reader :ships_to_place, :board, :placed_ships, :ship_sizes, :attacked_spaces
  def initialize(board=Board.new)
    @ship_sizes = {
      :V => 4,
      :B => 3,
      :S => 2
      # :CC => 2,
      # :DD => 1,
    }
    @ships_to_place = @ship_sizes.keys
    @board = board
    @placed_ships = []
    @attacked_spaces = []
  end
  def lost?
    @board.lost?
  end
  def finished_setting_ships?
    @ships_to_place.length < 1
  end
  def pop_next_ship_to_place
    # byebug
    @ships_to_place.pop
  end
  def remove_ship_from_ships_to_place(ship)
    @ships_to_place.delete(ship)
  end
  def get_array_of_spaces_taken_by_ship(ship, pos, rot)
    ship_size = @ship_sizes[ship]
    @board.get_array_of_spaces(ship_size, pos, rot)
  end
  def attack(other_board, pos)
    # p other_board.[]([pos[0], pos[1]])
    return false if @attacked_spaces.include?(pos)
    p "Firing at #{pos}"
    @attacked_spaces << pos
    other_board.attack(pos)
  end
  #BOOLEAN METHOD, consider adding ? to name.
  def place_ship_at_location(ship, pos=[0,0], rot="horizontal")
    spaces = get_array_of_spaces_taken_by_ship(ship, pos, rot)
    #if any spaces are already occupied, return false
    spaces.each do |e|
      # p "#{e}, empty? #{@board.empty?(e)}"
      #this should go to the ship placement screen
      return false if !@board.empty?(e)
    end
    #otherwise, fill those spaces with the ship name
    spaces.each do |e|
      # p "#{e}"
      @board.grid[e[0]][e[1]] = "[#{ship.to_s.chars[0]}]"
    end
    #this should go to the Pick the next ship to place screen
    @placed_ships << ship
    remove_ship_from_ships_to_place(ship)
    true
  end
end
class Computer < Player
  # attr_accessor :finished_setting_ships, :board
  # # include Player
  # def initialize(board, ships_to_place)
  #
  # end
  # attr_accessor :ships_to_place
  def initialize
    @board = Player.new.board
    @ships_to_place = Player.new.ships_to_place
    @placed_ships = Player.new.placed_ships
    @ship_sizes = Player.new.ship_sizes
    @attacked_spaces = []
    # @ships_to_place = [1,2]
  end
  def place_ships
    place_ships_randomly
  end
  def attack_prompt(other_board)
    fire_randomly(other_board)
  end
  def place_ships_randomly
    num_ships = @ships_to_place.length
    next_ship = @ships_to_place.pop
    while @placed_ships.length < num_ships
      #if we successfully placed the ship, pick the next one
      if place_ship_randomly(next_ship)
        next_ship = @ships_to_place.pop
      end
    end
    # @board.render
    p "Computer has placed their ships."
  end
  def place_ship_randomly(ship)
    (rand*2).floor == 0 ? rand_rot = "vertical" : rand_rot = "horizontal"
    x_mod = 0
    y_mod = 0
    #to prevent OOB, modify the random num generator by ship size based on orientation
    rand_rot == "horizontal" ? y_mod = @ship_sizes[ship] : x_mod = @ship_sizes[ship]
    rand_x = (rand*((@board.grid.length) - x_mod)).floor
    rand_y = (rand*((@board.grid.length) - y_mod)).floor
    place_ship_at_location(ship, [rand_x, rand_y], rand_rot)
  end
  def fire_randomly(other_board)
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    # other_board.render
    rand_x = (rand*(@board.grid.length)).floor
    rand_y = (rand*(@board.grid.length)).floor
    if !attack(other_board, [rand_x, rand_y])
      return fire_randomly(other_board)
    end
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    p "******COMPUTER IS ATTACKING*******"
    # p "Computer fired on #{rand_x}, #{rand_y}"
  end
  # def ships_to_place
  #   @ships_to_place
  # end
  # def place_ship(ship)
  #   @ships_to_place = []
  # end
  # def pop_next_ship
  #   @ships_to_place.pop
  # end
end
# x = Computer.new
# x.place_ships_randomly
# other_board = Board.new
# # x.attack(other_board, [1,0])
# x.fire_randomly(other_board)
# # y = ComputerPlayer.new
# # p y.ships_to_place2
# # p x.board
# # y = Player.new(Board.new)
# # p y.ships_to_place
# # p x.ships_to_place
# # next_ship = x.pop_next_ship_to_place
# # p next_ship
# # x.place_ship(next_ship)
# # p x.placed_ships
# # # x.place_ship_at_location(ship)
# # p x.finished_setting_ships?
# # p y.finished_setting_ships?
# y = Human.new
class Human < Player
  def initialize
    @board = Player.new.board
    @ships_to_place = Player.new.ships_to_place
    @placed_ships = Player.new.placed_ships
    @ship_sizes = Player.new.ship_sizes
    @attack_grid = Attack_Grid.new(@board.grid.length)
    @attacked_spaces = []
  end
  def place_ships
    @board.render
    while !finished_setting_ships?
      #player picks the ship
      ship = place_ship_type_prompt
      #player picks a location to place it
      location = place_ship_location_prompt(ship)
      p "Player is placing #{ship} at #{location}"
      # byebug
      place_ship_at_location(ship, location)
      # remove_ship_from_ships_to_place(ship)
    end
    @board.render
    p "Player is finished setting their ships"
    # place_ship_location_prompt(ship)
  end
  def attack_prompt(other_board, pos=[0,0])
    p "Your Board:"
    @board.render
    p "Attack grid: Use the arrow keys to move the cursor, then spacebar to fire"
    x = pos[0]
    y = pos[1]
    @attack_grid.set_cursor(pos)
    @attack_grid.render
    end_turn = false
    input = get_player_keypress
    if input == "spacebar" || input == "enter"
      #if they try a previously tried cell
      other_board_cell_value = attack(other_board, pos)
      if other_board_cell_value == false
        return attack_prompt(other_board, pos)
      elsif other_board_cell_value == "Miss"
        p "Missed!"
        @attack_grid.mark_miss(pos)
      else
        p "Hit #{other_board_cell_value}"
        @attack_grid.mark_hit(pos)
      end
      end_turn = true
    elsif input == "up" && x > 0
      x -= 1
    elsif input == "down" && x < (@attack_grid.grid.length - 1)
      x += 1
    elsif input == "right" && y < (@attack_grid.grid.length - 1)
      y += 1
    elsif input == "left" && y > 0
      y -= 1
    elsif input == "escape"
      abort
    end
    attack_prompt(other_board, [x,y]) if !end_turn
  end
  def place_ship_type_prompt
    # byebug if @ships_to_place.length == 0
    # return false if @ships_to_place.length == 0
    ship_names = {
      :D => "(D)estroyer [DD]",
      :C => "(C)ruiser [CC]",
      :V => "c(A)rrier [CV]",
      :B => "(B)attleship [BB]",
      :S => "(S)ubmarine [SS]"
    }
    str=""
    @ships_to_place.each do |e|
      str+=ship_names[e]+"\t"
    end
    puts "Enter a ship to place: #{str} "
    input = get_ship_type_input
    if !@ships_to_place.include?(input)
      return place_ship_type_prompt
    end
    input
  end
  def place_ship_location_prompt(ship, pos=[0,0], rot="vertical")
    # @board.clear_temp_spaces
    spaces = get_array_of_spaces_taken_by_ship(ship, pos, rot)
    render_placeholder_on_board(spaces)
    puts "Use the arrows to move the ship, space to rotate, enter to confirm"
    #get input from the player
    # input = STDIN.getch
    input = get_player_keypress
    #pos is nil
    handle_player_ship_placement_input(ship, input, pos, rot)
    # move_ship_on_board(input, @board.traverse())
  end
  #send in array of positions occupied by the ship
  def render_placeholder_on_board(arr)
    # p arr
    # arr.each do |e|
    #   if @board.empty?([e[0], e[1]])
    #     @board.grid[e[0]][e[1]] = "[X]"
    #   end
    # end
    # @board.render
    @board.render_array_on_grid("[X]", arr)
  end
  def get_ship_type_input
    input = gets.downcase.chomp
    ship = :D if input == "d" || input == "destroyer" || input == "dd"
    ship = :C if input == "c" || input == "cruiser" || input == "cc"
    ship = :V if input == "a" || input == "carrier" || input == "cv"
    ship = :B if input == "b" || input == "battleship" || input == "bb"
    ship = :S if input == "s" || input == "submarine" || input == "ss"
    ship
  end
  #returns keypress
  def get_player_keypress
    input = STDIN.getch
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    if input == "\e[A"
      return "up"
    elsif input == "\e[B"
      return "down"
    elsif input == "\e[C"
      return "right"
    elsif input == "\e[D"
      return "left"
    elsif input == " "
      return "spacebar"
    elsif input == '\u0003' || input == "\e"
      abort #escape key
    elsif input == "\r"
      return "enter"
    end
  end
  def handle_player_ship_placement_input(ship, input, pos, rot)
    x = pos[0]
    y = pos[1]
    size = @ship_sizes[ship]
    rot == "vertical" ? xsize = size : xsize = 0
    rot == "horizontal" ? ysize = size : ysize = 0
    placed_ship = false
    #code from https://gist.github.com/acook/4190379
    if input == "up" && x > 0
      x -= 1
    elsif input == "down" && x + xsize < (@board.grid.length - 1)
      x += 1
    elsif input == "right" && y + ysize < (@board.grid.length - 1)
      y += 1
    elsif input == "left" && y > 0
      y -= 1
    elsif input == "spacebar"
      if rot == "vertical"
        y = y - size  if y + size > (@board.grid.length - 1)
        rot = "horizontal"
      else
        x = x - size if x + size > (@board.grid.length - 1)
        rot = "vertical"
      end
    elsif input == "escape"
      return false
    elsif input == "enter"
      placed_ship = place_ship_at_location(ship, pos, rot)
    end
    p "in: #{input}, x: #{x}, y: #{y}, size:#{size}, rot: #{rot}"
    placed_ship ? [x,y] : place_ship_location_prompt(ship, [x, y], rot)
  end

end

# x = Human.new
# y = Computer.new
# y.place_ships_randomly
# # p y.lost?
# x.attack_prompt(y.board)

# x.place_ships

class HumanPlayer
  attr_accessor :name, :board, :attack_board, :finished_setting_ships
  def initialize(name, board)
    @name = name
    @board = board
    @attack_grid = Attack_Grid.new
    @ships_to_place = board.SHIPS.keys
    @finished_setting_ships = false
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
  def attack_prompt
    p "should be empty:"
    @attack_grid.render
    puts "Select a space to attack: "
    get_and_handle_player_attack_input
  end
  def place_ship_type_prompt
    # byebug if @ships_to_place.length == 0
    # return false if @ships_to_place.length == 0
    ship_names = {
      :DD => "(D)estroyer [DD]",
      :CC => "(C)ruiser [CC]",
      :CV => "c(A)rrier [CV]",
      :BB => "(B)attleship [BB]",
      :SS => "(S)ubmarine [SS]"
    }
    str=""
    @ships_to_place.each do |e|
      str+=ship_names[e]+"\t"
    end
    puts "Enter a ship to place: #{str} "
    input = gets.downcase.chomp
    ship = :DD if input == "d" || input == "destroyer" || input == "dd"
    ship = :CC if input == "c" || input == "cruiser" || input == "cc"
    ship = :CV if input == "a" || input == "carrier" || input == "cv"
    ship = :BB if input == "b" || input == "battleship" || input == "bb"
    ship = :SS if input == "s" || input == "submarine" || input == "ss"
    if !@ships_to_place.include?(ship)
      place_ship_type_prompt
    else
      return ship
      # place_ship_location_prompt(ship)
    end
  end


  #pos is the top, leftmost position of the ship
  def place_ship_location_prompt(ship, pos=[0,0], rot="vertical")
    @board.clear_temp_spaces
    spaces = get_array_of_spaces_taken_by_ship(ship, pos, rot)
    render_ship_on_board(spaces)
    puts "Use the arrows to move the ship, space to rotate, enter to confirm"
    #get input from the player
    # input = STDIN.getch
    get_and_handle_player_ship_placement_input(ship, pos, rot)
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
  #returns keypress
  def get_and_interpret_player_input
    input = STDIN.getch
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    if input == "\e[A"
      return "up"
    elsif input == "\e[B"
      return "down"
    elsif input == "\e[C"
      return "right"
    elsif input == "\e[D"
      return "left"
    elsif input == " "
      return "spacebar"
    elsif input == '\u0003' || input == "\e"
      return "escape"
    elsif input == "\r"
      return "enter"
    end
  end
  def get_and_handle_player_attack_input(pos=[0,0])
    x = pos[0]
    y = pos[1]
    # @attack_grid[x][y] = "X"
    @attack_grid.clear_cursor
    @attack_grid.set_cursor(pos)
    @attack_grid.render
    input = get_and_interpret_player_input
    if input == "escape"
      return false
    end
    #TO DO: Add logic here to move cursor along attack grid
    if input == "spacebar" || input == "enter"
      #attack that cell if hasn't already been attacked
      p "ATTACK! #{pos}"
      if (@board.attack(pos))
        @attack_grid.mark_success(@board[pos], pos)
      else
        @attack_grid.mark_fail(pos)
      end
    end
    if input == "up" && x - 1 >= 0
      x -= 1
    elsif input == "down" && x + 1 < @attack_grid.grid.length
      x += 1
    elsif input == "right" && y + 1 < @attack_grid.grid.length
      y += 1
    elsif input == "left" && y - 1 >= 0
      y -= 1
    end
    p "x: #{x} y: #{y}"
    get_and_handle_player_attack_input([x,y])
    #call handle player attack input with new position
  end
  def get_and_handle_player_ship_placement_input(ship, pos, rot)
    x = pos[0]
    y = pos[1]
    size = board.SHIPS[ship]
    rot == "vertical" ? xsize = size : xsize = 0
    rot == "horizontal" ? ysize = size : ysize = 0
    input = get_and_interpret_player_input
    # if input == "\e" then
    #   input << STDIN.read_nonblock(3) rescue nil
    #   input << STDIN.read_nonblock(2) rescue nil
    # end
    #code from https://gist.github.com/acook/4190379
    if input == "up" && x > 0
      x -= 1
    elsif input == "down" && x + xsize < (board.grid.length - 1)
      x += 1
    elsif input == "right" && y+ysize < (board.grid.length - 1)
      y += 1
    elsif input == "left" && y > 0
      y -= 1
    elsif input == "spacebar"
      if rot == "vertical"
        y = y - size  if y + size > (@board.grid.length - 1)
        rot = "horizontal"
      else
        rot = "vertical"
      end
    elsif input == "escape"
      return false
    elsif input == "enter"
      if place_ship_at_location(ship, pos, rot)
        if @ships_to_place.length > 0
          return place_ships
        else
          @finished_setting_ships = true
          return 0
        end
      end
      # place_ships if  && @ships_to_place.length > 0
      # place_ships if @ships_to_place.length > 0
    end
    p "in: #{input}, x: #{x}, y: #{y}, size:#{size}, rot: #{rot}"
    place_ship_location_prompt(ship, [x, y], rot)
  end
  def place_ship_at_location(ship, pos, rot)
    # byebug
    spaces = get_array_of_spaces_taken_by_ship(ship, pos, rot)
    #if any spaces are already occupied, return false
    spaces.each do |e|
      # p "#{e}, empty? #{@board.empty?(e)}"
      #this should go to the ship placement screen
      return false if !board.empty?(e)
    end
    #otherwise, fill those spaces with the ship name
    spaces.each do |e|
      # p "#{e}"
      @board.grid[e[0]][e[1]] = ship
    end
    remove_from_ship_list(ship)
    #this should go to the Pick the next ship to place screen
    true
  end
  def remove_from_ship_list(ship)
    @ships_to_place.delete(ship)
  end
  def place_ships
    @board.render
    # ship = place_ship_type_prompt
    ship = place_ship_type_prompt
    place_ship_location_prompt(ship)
    @finished_setting_ships = true
    # p ship
  end
end
# board = Board.new
# board.grid[1][1] = :BB
# p1 = HumanPlayer.new("name",Board.new)
# p1.place_ships
# p1.board.render
# p1.attack_prompt
# p1.place_ship_location_prompt(:DD, [0,0])
