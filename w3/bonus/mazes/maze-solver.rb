
require 'byebug'
filename = "maze1.txt"
grid = []
File.foreach(filename) do |c|
  grid << c
end

class Solver
  attr_accessor :position, :facing
  def initialize(grid)
    @grid = grid
    @position = find_char('S')
    @end = find_char('E')
    @visited_cells = []
    @facing = 'up'
  end
  def find_char(c)
    @grid.each_index do |i|
      @grid[i].chars.each_index do |j|
        return [j,i] if @grid[i][j] == c
      end
    end
    nil
  end
  def up_cell
    x = @position[0]; y = @position[1]
    @grid[y-1][x]
  end
  def up_cell_coords
    x = @position[0]; y = @position[1]
    [y-1,x]
  end
  def down_cell
    x = @position[0]; y = @position[1]
    @grid[y+1][x]
  end
  def down_cell_coords
    x = @position[0]; y = @position[1]
    [y+1,x]
  end
  def left_cell
    x = @position[0]; y = @position[1]
    @grid[y][x-1]
  end
  def left_cell_coords
    x = @position[0]; y = @position[1]
    [y,x-1]
  end
  def right_cell
    x = @position[0]; y = @position[1]
    @grid[y][x+1]
  end
  def right_cell_coords
    x = @position[0]; y = @position[1]
    [y,x+1]
  end
  def move?(dir)
    x = @position[0]
    y = @position[1]
    return true if dir == 'up' && up_cell != '*'
    return true if dir == 'down' && down_cell != '*'
    return true if dir == 'left' && left_cell != '*'
    return true if dir == 'right' && right_cell != '*'
    return false
  end
  def move!(dir)
    x = @position[0]
    y = @position[1]
    newx = x
    newy = y
    newy -= 1 if dir == 'up' && move?(dir)
    newy += 1 if dir == 'down' && move?(dir)
    newx -= 1 if dir == 'left' && move?(dir)
    newx += 1 if dir == 'right' && move?(dir)
    @position = [newx, newy]
  end
  def move_forward?
    move?(@facing)
  end
  def move_forward!
    # p "moving #{@facing}"
    move!(@facing)
  end
  def turn_left!
    return @facing = 'left' if @facing == 'up'
    return @facing = 'down' if @facing == 'left'
    return @facing = 'right' if @facing == 'down'
    return @facing = 'up' if @facing == 'right'
  end
  def turn_right!
    return @facing = 'right' if @facing == 'up'
    return @facing = 'down' if @facing == 'right'
    return @facing = 'left' if @facing == 'down'
    return @facing = 'up' if @facing == 'left'
  end
  #the cell left relative to the direction solver is facing
  def relative_left_cell
    return left_cell if @facing == 'up'
    return up_cell if @facing == 'right'
    return right_cell if @facing == 'down'
    return down_cell if @facing == 'left'
  end
  def left_hand_solve(count=0)
    x = @position[0]
    y = @position[1]
    @visited_cells << [y,x]
    # p @visited_cells
    # if !@visited_cells.include?(left_cell_coords) && move?('left')
    #   move!('left')
    # elsif !@visited_cells.include?(up_cell_coords) && move?('up')
    #   move!('up')
    # elsif !@visited_cells.include?(right_cell_coords) && move?('right')
    #   move!('right')
    # elsif !@visited_cells.include?(down_cell_coords) && move?('down')
    #   move!('down')
    # end

    if relative_left_cell == " "
      turn_left!
    elsif relative_left_cell != "*" || !move_forward?
      turn_right!
    end
    move_forward!
    # render
    if @position != @end
      left_hand_solve(count+1)
    else
      p "Finished! Took #{count} moves"
    end
    # if move?('up') &&
    #find cell where '*' is to the left ignoring cells previously visited
  end
  def render
    @grid.each_index do |i|
      @grid[i].chars.each_index do |j|
        ([j,i] == @position) ? (print "A") : (print @grid[i][j])
      end
    end
  end

  def render_moves
    @grid.each_index do |i|
      @grid[i].chars.each_index do |j|
        (@visited_cells.include?([i,j])) ? (print "@") : (print @grid[i][j])
      end
    end
  end
end

solver = Solver.new(grid)
solver.render
# solver.move_forward!
solver.left_hand_solve
solver.render_moves
# solver.render
# solver.turn_left!
# solver.move_forward!
# solver.turn_right!
# solver.move_forward!
# solver.render
