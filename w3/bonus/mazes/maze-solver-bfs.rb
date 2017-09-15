#WARNING: Will break if the graph has blanks
#make sure graph is a completely filled rectangle
filename = "maze3.txt"
yxgrid = []
i = 0
maxlength = 0
File.foreach(filename) do |c|
  if c[0] == '#'
    next
  else
    yxgrid << []
    maxlength = c.length if c.length > maxlength
    c.chars.each do |d|
      yxgrid[i] << d
    end
    i+=1
  end
end


#essentially a transposed grid so you access [x][y] instead of [y][x]
xygrid = []
maxlength.times {xygrid << []}
yxgrid.each do |e|
  i = 0
  e.each do |f|
    xygrid[i] << f
    i += 1
  end
end

# p yxgrid[1][2]
# READING THE GRID
# xy grid accesses elements [x][y]
# yx grid accesses elements [y][x]
# y counting up goes down on screen
# x counting up goes right on screen
#only works on mazes that are completely filled rectangles
class Graph
  attr_accessor :nodes, :grid
  def initialize(grid)
    @nodes = []
    @grid = grid
  end
  def new_node(pos)
    node = Node.new
    node.pos = pos
    @nodes << node
    @nodes.last
  end
  #all nodes are bidirectional in a maze
  def connect_nodes(n,m)
    #check if nodes exist in the graph
    return false if (!@nodes.include?(n) || !@nodes.include?(m))
    #check if these nodes are already connected
    return false if (n.adj.include?(m) || m.adj.include?(n))
    n.adj << m
    m.adj << n
    true
  end
  def grid_to_nodes
    #go through grid and look for spaces.
    #if we find a space,
    #check LEFT and check UP for other spaces
    #if space found, connect the two.
    #we only need to check up and left because we don't
    #want to double check cells(only previous cells are checked)
    grid2 = grid.dup
    i = 0
    while i < grid.length
      j = 0
      while j < grid[i].length
        j+=1
        #match S, E, or whitespace (\s)
        if grid[i][j] =~ /[SE\s]/
          #add node to graph with position i, j
          node = new_node([i,j])
          #set the type to whatever the grid character is, either S, E or whitespace
          node.type = grid[i][j]
          #set grid space to a node (maybe unnecessary)
          grid[i][j] = node
          #check the up and left cells
          up_cell = up_cell(i, j)
          left_cell = left_cell(i, j)
          #if the up or left cells are also nodes, connect them.
          connect_nodes(node, up_cell) if up_cell.class == Node
          connect_nodes(node, left_cell) if left_cell.class == Node
        end
      end
      # @grid[i].each do |x|
      #   if x==" "
      #   print x
      # end
      # print "\n"
      i+=1
    end
    # @nodes.each do |n|
    #   p n.adj.length
    # end
  end
  def up_cell(x,y)
    @grid[x][y-1]
  end
  def left_cell(x,y)
    @grid[x-1][y]
  end
  def render
    i = 0
    while i < @grid.length
      j = 0
      while j < @grid[i].length
        if @grid[j][i].class == Node
          print grid[j][i].adj.length
        else
          print grid[j][i]
        end
        # print "#{j},#{i} "
        j += 1
      end
      print "\n"
      i += 1
    end
  end
  def depth_first_search

  end
end
class Node
  attr_accessor :adj, :marked, :num, :pos, :type
  def initialize
    @adj = []
    @marked = false
  end
end
x = Graph.new(xygrid)
x.grid_to_nodes
x.render
#p x.nodes[2].adj[0].type
# x.new_node(0)
# x.new_node(1)
# x.connect_nodes(0, 1)
# p x.nodes[1].adj[0] == x.nodes[0]
#use breadth first search to solve.
#take any unmarked passage unrolling string behind
#mark intersections and passages when first visited
#retrace steps at marked intersection
#retrace steps when no unvisited options remain
