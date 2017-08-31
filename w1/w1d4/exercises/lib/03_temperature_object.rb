class Temperature
  attr_accessor :fahrenheit, :celsius
  def initialize(options={})
    if options[:f]
      self.fahrenheit = options[:f]
    else
      self.celsius = options[:c]
    end
  end
  def in_fahrenheit
     self.fahrenheit.nil? ? ctof(self.celsius) : self.fahrenheit
  end
  def in_celsius
     self.celsius.nil? ? ftoc(self.fahrenheit) : self.celsius
  end
  def ftoc(f)
    (f-32).to_f * (5.0/9.0)
  end
  def ctof(c)
    (c.to_f * (9.0/5.0)) + 32
  end
  def Temperature.from_celsius(t)
    celsius = Celsius.new(t)
    # return self
  end
  def Temperature.from_fahrenheit(t)
    fahrenheit = Fahrenheit.new(t)
    # return self
  end
end
class Fahrenheit < Temperature
  # attr_accessor :fahrenheit
  def initialize(t)
    self.fahrenheit = t
  end
end
class Celsius < Temperature
  # attr_accessor :celsius
  def initialize(t)
    self.celsius = t
  end
end




# class Temperature
#   # TODO: your code goes here!
#   attr_accessor :f, :c
#   def initialize(options={})
#     if options[:f]
#       @f = Fahrenheit.new(options[:f])
#     else
#       @c = Celsius.new(options[:c])
#     end
#   end
#   def ftoc(f)
#     (f-32).to_f * (5.0/9.0)
#   end
#   def ctof(c)
#     (c.to_f * (9.0/5.0)) + 32
#   end
#   def from_fahrenheit(t)
#     return Fahrenheit.new(t)
#   end
#   def from_celsius(t)
#     return Celsius.new(t)
#   end
#   def in_celsius
#
#   end
# end
# class Fahrenheit < Temperature
#   attr_accessor :temp
#   def initialize(temp)
#     @temp = temp
#   end
#   def in_fahrenheit
#     @temp
#   end
#   def in_celsius
#     ftoc(@temp)
#   end
# end
# class Celsius < Temperature
#   attr_accessor :temp
#   def initialize(temp)
#     @temp = temp
#   end
#   def in_fahrenheit
#     ctof(@temp)
#   end
#   def in_celsius
#     @temp
#   end
#
# end
# # x = Fahrenheit.new
# y = Temperature.new(:f => 20)
# y.in_fahrenheit
# p y.ftoc(32)
# p y.ctof(0)
