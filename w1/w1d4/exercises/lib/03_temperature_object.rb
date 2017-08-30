class Temperature
  # TODO: your code goes here!
  attr_accessor :f, :c
  def initialize(options={})
    if options[:f]
      @f = Fahrenheit.new(options[:f])
      @c = Celsius.new(ftoc(options[:f]))
    end
    if options[:c]
      @f = Fahrenheit.new(ctof(options[:c]))
      @c = Celsius.new(options[:c])
    end
  end
  def ftoc(f)
    (f-32).to_f * (5.0/9.0)
  end
  def ctof(c)
    (c.to_f * (9.0/5.0)) + 32
  end
  def from_fahrenheit(t)

  end
  def from_celsius(t)

  end
end
class Fahrenheit < Temperature
  attr_accessor :temp
  def initialize(temp)
    @temp = temp
  end
  def in_fahrenheit
    @temp
  end
  def in_celsius
    ftoc(@temp)
  end
end
class Celsius < Temperature
  attr_accessor :temp


end
# x = Fahrenheit.new
y = Temperature.new(:f => 20)
y.in_fahrenheit
p y.ftoc(32)
p y.ctof(0)
