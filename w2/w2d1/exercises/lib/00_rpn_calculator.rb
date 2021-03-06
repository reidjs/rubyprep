# Works fine when you send the operations (:+, :- etc) but the problem is
# the operation functions will try to evaluate :+ :- etc as numbers.
# to fix you must invoke send whenever these are reached, OTHERWISE you can
# evaluate the next two numbers in the stack


require 'byebug'
# require 'pry'
class RPNCalculator
  attr_accessor :value
  def initialize
    @stack = []
    @ops = {
      "+" => :+,
      "-" => :-,
      "/" => :/,
      "*" => :*,
    }
  end
  def push(e)
    @stack << e
  end
  def perform_other_operation(val)
    if @ops.values.include?(val)
      self.send(val)
    end
  end
  def plus
    raise 'calculator is empty' if @stack.length < 2
    a = @stack.pop
    b = @stack.pop

    @stack << a + b
    @value = @stack.last
  end
  def minus
    raise 'calculator is empty' if @stack.length < 2
    a = @stack.pop
    b = @stack.pop

    @stack << b-a
    @value = @stack.last
  end
  def times
    raise 'calculator is empty' if @stack.length < 2
    @stack << @stack.pop * @stack.pop
    @value = @stack.last
  end
  def divide
    raise 'calculator is empty' if @stack.length < 2
    a = @stack.pop.to_f
    b = @stack.pop.to_f

    @stack << b / a
    @value = @stack.last
  end
  def tokens(str)
    str.split(' ').each do |c|
      self.push(c.to_i) if !(c =~ /[0123456789]/).nil?
      self.push(@ops[c]) if @ops.keys.include?(c)
    end
    @stack
  end

  def evaluate(str)
    str.split(' ').each do |c|
      self.push(c.to_i) if !(c =~ /[0123456789]/).nil?
      self.send(@ops[c]) if @ops.keys.include?(c)
    end
    @stack.pop
  end
  alias_method :+, :plus
  alias_method :-, :minus
  alias_method :*, :times
  alias_method :/, :divide
end
# calculator = RPNCalculator.new
# calculator.evaluate("1 2 3 * +")


# # # calculator.push(4)
# # calculator.plus
# # calculator.value
# # calculator.plus
# # calculator.value
# binding.pry
