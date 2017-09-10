#break apart number into ones, tens, hundreds, etc.
#parse the stack and turn each into
require 'byebug'
# require 'pry'
ONES = {
  0 => "",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine"
}
TEENS = {
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
}
TENS = {
  10 => "ten",
  20 => "twenty",
  30 => "thirty",
  40 => "forty",
  50 => "fifty",
  60 => "sixty",
  70 => "seventy",
  80 => "eighty",
  90 => "ninety"
}
#number + magnitude = word
#90,000 = ninety + thousand
#143 = one + hundred + forty + three
#5,670 = five + thousand + six + hundred + seventy
class Fixnum
  def in_words
    # digits = digitize(self)
    # str = ""
    # if self < 100
    #   str = less_than_hundred_to_word(self)
    # elsif self < 1000
    #   str = less_than_thousand_to_word(self)
    # elsif self < 1_000_000_000
    #   str = less_than_million(self)
    #   thousand_digits = []
    #   while digits.length > 3
    #     thousand_digits << digits.shift
    #   end
    #   p less_than_hundred_to_word(thousand_digits.join.to_i) + " thousand "
    # end
    # p str
    #[1,0,0,0] -> [0,0,0,1]
    #11,000 -> 00011
    str = ""
    digits = digitize(self)
    if self > 999_999_999_999
      trillions = digits.reverse[12..14].reverse
      str += add_magnitude(trillions, "trillion")  if trillions.join.to_i > 0
    end
    if self > 999_999_999
      billions = digits.reverse[9..11].reverse
      str += add_magnitude(billions, "billion")  if billions.join.to_i > 0
    end
    if self > 999_999
      millions = digits.reverse[6..8].reverse
      str += add_magnitude(millions, "million")  if millions.join.to_i > 0
    end
    if self > 999
      thousands = digits.reverse[3..5].reverse
      str += add_magnitude(thousands, "thousand") if thousands.join.to_i > 0
    end
    # if self > 99
    #   p digits
    #   hundreds = digits.reverse[2..2]
    #   p hundreds
    #   str += add_magnitude(hundreds, "hundred")
    # end
    if self > 0
      hundreds = digits.reverse[0..2].reverse
      str += add_magnitude(hundreds,"")
    end
    if self == 0
      str = "zero"
    end
    str.strip
  end
  def add_magnitude(digits, magnitude)
    return less_than_thousand_to_word(digits.join.to_i) + " "+magnitude+" "
  end
  # def wordicize(digits, magnitude)
  #   partial = []
  #   if digits.length < 4
  #     return str + less_than_thousand_to_word(digits.join.to_i)
  #   end
  #   partial << digits.shift
  #   while digits.length % 3 != 0
  #     partial << digits.shift
  #   end
  #   # p digits
  #   str << partial.join
  #   wordicize(str, digits)
  # end

  def less_than_hundred_to_word (value)
    return nil if value > 99
    digits = digitize(value)
    if value < 10
      return ONES[value]
    elsif value % 10 == 0
      return TENS[value]
    elsif value > 10 && value < 20
      return TEENS[value]
    else
      return TENS[digits[0]*10] + " " + ONES[digits[1]]
    end
  end
  def less_than_thousand_to_word(value)
    return nil if value > 999
    return less_than_hundred_to_word(value) if value < 100
    digits = digitize(value)
    return ONES[digits[0]] + " hundred " +
        less_than_hundred_to_word(value-100*digits[0])
  end
  #create array of digits (integers)
  def digitize(value)
    value.to_s.split('').map{|v| v.to_i}
  end
end
# p 88999100000023.in_words.strip
# class Fixnum
#   def in_words
#
#     powers = {
#       1 => :tens,
#       2 => :hundreds,
#       3 => :thousands,
#       4 => :thousands,
#       5 => :thousands,
#       6 => :millions,
#       7 => :millions,
#       8 => :millions,
#       9 => :billions,
#       12 => :trillions
#     }
#     amount = self
#     str = ""
#     digits = amount.to_s.split('')
#     power = digits.length-1
#     while amount > 0
#       if word(amount).nil?
#         #p amount
#         next_place = digits.shift.to_i * 10**power
#         # p next_place
#         amount -= next_place
#         # byebug
#         str += self.send(powers[power], next_place)
#
#         power -= 1
#       else
#         # p word(amount)
#         str += word(amount)
#         amount -= amount
#       end
#     end
#     str.strip
#   end
#   #returns nil if there is not a pure word for it.
#   #otherwise returns string
#   def word(num)
#     words = {
#       1 => "one",
#       2 => "two",
#       3 => "three",
#       4 => "four",
#       5 => "five",
#       6 => "six",
#       7 => "seven",
#       8 => "eight",
#       9 => "nine",
#       10 => "ten",
#       11 => "eleven",
#       12 => "twelve",
#       13 => "thirteen",
#       14 => "fourteen",
#       15 => "fifteen",
#       16 => "sixteen",
#       17 => "seventeen",
#       18 => "eighteen",
#       19 => "nineteen",
#       20 => "twenty",
#       30 => "thirty",
#       40 => "fourty",
#       50 => "fifty",
#       60 => "sixty",
#       70 => "seventy",
#       80 => "eighty",
#       90 => "ninety"
#     }
#     return words[num]
#   end
#
#   def ones(val)
#     word(val)
#   end
#   def tens(val)
#     word(val)
#   end
#   def hundreds(val)
#     word(val/100) + " hundred "
#   end
#   def thousands(val)
#     w = word(val/1000)
#     if (w).nil?
#       return ""
#     else
#       return word(val/1000) + " thousand "
#     end
#   end
#   def ten_thousands(val)
#     word(val/1000) + " thousand "
#   end
# end
# WORDS = {
#   0 => "zero",
#   1 => "one",
#   2 => "two",
#   3 => "three",
#   4 => "four",
#   5 => "five",
#   6 => "six",
#   7 => "seven",
#   8 => "eight",
#   9 => "nine",
#   10 => "ten",
#   11 => "eleven",
#   12 => "twelve",
#   13 => "thirteen",
#   14 => "fourteen",
#   15 => "fifteen",
#   16 => "sixteen",
#   17 => "seventeen",
#   18 => "eighteen",
#   19 => "nineteen",
#   20 => "twenty",
#   30 => "thirty",
#   40 => "fourty",
#   50 => "fifty",
#   60 => "sixty",
#   70 => "seventy",
#   80 => "eighty",
#   90 => "ninety"
# }
# MAGS = {
#   2 => "hundred",
#   3 => "thousand"
# }
# str = ""
# $amount = 100000
# def a(amt)
#   if amt < 10
#     b(amt, 0) # b(0)
#   elsif amt < 100
#     b(amt, 1)
#   elsif amt < 1000
#     b(amt, 2)
#   elsif amt < 1_000_000
#     b(amt, 3)
#     # str += b(3).to_s + " thousand"
#   elsif amt < 1_000_000_000
#     b(amt, 6)
#   end
# end
# def b(amt, mag)
#   t = amt/10**mag
#   if WORDS[t]
#     p WORDS[t], MAGS[mag]
#   else
#
#     a(t)
#   end
# end
#
# a(150)

# p 11505.in_words
# p 11.in_words
# p 20.in_words
# p 200.in_words
# binding.pry
