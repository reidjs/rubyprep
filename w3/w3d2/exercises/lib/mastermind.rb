
class Code
  attr_reader :pegs
  @colors = ["r", "o", "y", "g", "b", "p"]
  def initialize(pegs)
    @pegs = pegs

  end
  def [](n)
    @pegs[n]
  end
  def ==(code)
    return false if !code.instance_of?(Code)
    return true if @pegs == code.pegs
    false
  end
  def exact_matches(code)
    count = 0
    code.pegs.each_index do |i|
      if code[i] == @pegs[i]
        count += 1
      end
    end
    count
  end
  def near_matches(code)
    counted = [] #use array because we don't want to include duplicates
    code.pegs.each_index do |i|
      if code[i] != @pegs[i] && @pegs.include?(code[i])
        counted << code[i]
      end
    end
    counted.uniq.length
  end
  def self.parse(str)
    arr = []
    str.downcase.chars.each do |c|
      if @colors.include?(c)
        arr << c
      else
        raise "Invalid color"
      end
    end
    Code.new(arr)
  end
  def self.random
    code = []
    4.times do
      code << @colors[rand(6)]
    end
    Code.new(code)
  end
end

class Game
  attr_reader :secret_code
  def initialize(code=self.random_code)
    @secret_code = code
  end
  def random_code
    Code.random
  end
  def get_guess
    Code.parse($stdout.string)
  end
  def display_matches(code)
    p "exact matches: ", @secret_code.exact_matches(code)
    p "near matches: ", @secret_code.near_matches(code)
  end
end

Code::PEGS = {}
# def random
#   colors = ["r", "o", "y", "g", "b", "p"]
#   code = []
#   4.times do
#     code << colors[rand(6)]
#   end
#   Code.new(code)
# end
