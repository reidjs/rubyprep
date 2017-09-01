#break apart number into ones, tens, hundreds, etc.
#parse the stack and turn each into
require 'byebug'
require 'pry'
class Fixnum
  def in_words

    powers = {
      1 => :tens,
      2 => :hundreds,
      3 => :thousands,
      4 => :thousands,
      5 => :thousands,
      6 => :millions,
      7 => :millions,
      8 => :millions,
      9 => :billions,
      12 => :trillions
    }
    amount = self
    str = ""
    digits = amount.to_s.split('')
    power = digits.length-1
    while amount > 0
      if word(amount).nil?
        #p amount
        next_place = digits.shift.to_i * 10**power
        # p next_place
        amount -= next_place
        # byebug
        str += self.send(powers[power], next_place)

        power -= 1
      else
        # p word(amount)
        str += word(amount)
        amount -= amount
      end
    end
    str.strip
  end
  #returns nil if there is not a pure word for it.
  #otherwise returns string
  def word(num)
    words = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine",
      10 => "ten",
      11 => "eleven",
      12 => "twelve",
      13 => "thirteen",
      14 => "fourteen",
      15 => "fifteen",
      16 => "sixteen",
      17 => "seventeen",
      18 => "eighteen",
      19 => "nineteen",
      20 => "twenty",
      30 => "thirty",
      40 => "fourty",
      50 => "fifty",
      60 => "sixty",
      70 => "seventy",
      80 => "eighty",
      90 => "ninety"
    }
    return words[num]
  end

  def ones(val)
    word(val)
  end
  def tens(val)
    word(val)
  end
  def hundreds(val)
    word(val/100) + " hundred "
  end
  def thousands(val)
    w = word(val/1000)
    if (w).nil?
      return ""
    else
      return word(val/1000) + " thousand "
    end
  end
  def ten_thousands(val)
    word(val/1000) + " thousand "
  end
end
WORDS = {
  0 => "zero",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
  10 => "ten",
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
  20 => "twenty",
  30 => "thirty",
  40 => "fourty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}
MAGS = {
  2 => "hundred",
  3 => "thousand"
}
str = ""
$amount = 100000
def a(amt)
  if amt < 10
    b(amt, 0) # b(0)
  elsif amt < 100
    b(amt, 1)
  elsif amt < 1000
    b(amt, 2)
  elsif amt < 1_000_000
    b(amt, 3)
    # str += b(3).to_s + " thousand"
  elsif amt < 1_000_000_000
    b(amt, 6)
  end
end
def b(amt, mag)
  t = amt/10**mag
  if WORDS[t]
    p WORDS[t], MAGS[mag]
  else
    
    a(t)
  end
end

a(150)

# p 11505.in_words
# p 11.in_words
# p 20.in_words
# p 200.in_words
# binding.pry
