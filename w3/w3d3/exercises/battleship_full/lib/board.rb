require 'byebug'
#Ship types and their lengths

class Board
  attr_reader :grid, :SHIPS
  def initialize(grid = Board.default_grid)
    @grid = grid
    # @SHIPS = {
    #   # :CV => 4,
    #   :BB => 3
    #   # :SS => 2,
    #   # :CC => 2,
    #   # :DD => 1,
    # }
    @attack_values = {
      "[ ]" => "Miss",
      "[V]" => "Carrier",
      "[B]" => "Battleship",
      "[C]" => "Cruiser",
      "[S]" => "Submarine"

    }
  end
  def self.default_grid
    default_size = 10
    g = []
    default_size.times do
      g << Array.new(default_size, "[ ]")
    end
    g
  end
  def get_array_of_spaces(size, pos, rot)
    # byebug
    x = pos[0]
    y = pos[1]
    # byebug
    rot == "vertical" ? x2 = x + size : x2 = x
    rot == "horizontal" ? y2 = y + size : y2 = y
    # p "sposition: #{pos}, eposition: #{[y2, x2]}"
    # render_ship_on_board(ship, @board.traverse(pos, [x2, y2]))
    traverse(pos, [x2, y2])
  end
  #a is starting position, b is ending point
  # def place_ship(ship, a, b)
  #   #make sure ship type exists
  #   return false if @SHIPS[ship].nil?
  #
  #   #ensure that ships are only placed horiz or vert
  #   #either 'x' pos should be equal or 'y' pos but not both
  #   return false if !((a[0] == b[0]) ^ (a[1] == b[1]))
  #   #ensure the ship length is equal to distance b/w points
  #   return false if @SHIPS[ship] != distance(a,b) + 1
  #   #make sure none of the spots are taken already
  #   grid_spaces = traverse(a, b)
  #   grid_spaces.each {|point| return false if !can_occupy_cell?(point)}
  #   #set each grid space to name of ship
  #   grid_spaces.each {|point| @grid[point[0]][point[1]] = ship}
  #   true
  #
  # end
  def clear_temp_spaces
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        @grid[j][i] = "[ ]" if @grid[j][i] == "[X]"
      end
    end
  end
  #walks from point a to point b and returns array of all
  #points in between
  def traverse(a, b, arr=[])
    arr << a if !arr.include?(a)
    arr << b if !arr.include?(b)
    x = a[0]
    y = a[1]
    x2 = b[0]
    y2 = b[1]
    if x < x2
      traverse([x+1, y], [x2, y2], arr)
    elsif x2 > x
      traverse([x, y], [x2-1,y2], arr)
    elsif x > x2
      traverse([x-1,y], [x2, y2], arr)
    elsif x2 < x
      traverse([x,y], [x2+1, y2], arr)
    end
    if y < y2
      traverse([x, y+1], [x2, y2], arr)
    elsif y2 > y
      traverse([x, y], [x2,y2-1], arr)
    elsif y > y2
      traverse([x,y-1], [x2, y2], arr)
    elsif y2 < y
      traverse([x,y], [y2+1, y2], arr)
    end
    arr
  end

  #returns distance between position a and position b
  def distance(a, b)
    Integer(Math.sqrt(((b[0] - a[0])**2 + (b[1] - a[1])**2)))
  end
  # def count
  #   count = 0
  #   @grid.each do |row|
  #     count += row.count(:s)
  #   end
  #   count
  # end
  #similar to empty but also checks grid dimensions
  def can_occupy_cell?(pos=false)
    # p pos
    # # byebug
    return false if pos[0] < 0 || pos[0] >= @grid.length
    return false if pos[1] < 0 || pos[1] >= @grid[0].length
    empty?(pos)
    # return false if (pos[0] >= @grid.length || pos[1] >= @grid.length)
    # return true if pos && @grid[pos[0]][pos[1]] != nil
    # false
  end
  def empty?(pos=false)
    return false if pos.nil? || pos == false
    # p pos
    cell = @grid[pos[0]][pos[1]]
    return true if pos == false || cell == "[ ]" || cell == "[X]"
    # return true if self.count == 0
    false
  end
  # def full?
  #   return true if (self.count == @grid.length**2)
  # end
  def lost?
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        return false if @grid[j][i] != "[ ]"
      end
    end
    true
  end
  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  def place_random_ship
    raise "Board is full!" if self.full?
    x = rand(@grid.length)
    y = rand(@grid.length)
    @grid[x][y] = "X"
  end
  def attack(pos)
    cell = @grid[pos[0]][pos[1]]
    value = @attack_values[cell]
    @grid[pos[0]][pos[1]] = "[ ]"
    # byebug if value != "Miss"
    value
    # if @attack_values[cell] != nil
    #   p "hit #{}"
    #   return true
    # end
    # p "miss"
    # return false
  end
  def render_array_on_grid(char, arr)
    clear_temp_spaces
    arr.each do |e|
      if empty?([e[0], e[1]])
        @grid[e[0]][e[1]] = char
      end
    end
    render
  end
  def render
    # clear_temp_spaces
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        print self.[]([row,col])
      end
      print "\n"
    end
  end
end
