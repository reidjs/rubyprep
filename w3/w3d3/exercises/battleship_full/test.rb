class DemoClass
  # class << self
  #   attr_accessor :x
  # end
  attr_reader :x
  def initialize
    @x = 2
  end
  # @my_var = "hello world"
end

class Demo2Class < DemoClass
  def put_x
    puts @x
  end
  # @my_var = "goodby world"
end
y = DemoClass.new
z = Demo2Class.new
puts y.x
puts z.x
# puts y.x
