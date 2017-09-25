# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
  f = []
  i = 1
  while i <= num
    f << i if num % i == 0
    i+=1
  end
  f
end

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
  # def bubble_sort!
  #   i = 0
  #   repeat = false
  #   while i < self.length - 1
  #     if self[i] > self[i+1]
  #       self[i], self[i+1] = self[i+1], self[i]
  #       repeat = true
  #     end
  #     i += 1
  #   end
  #   repeat ? self.bubble_sort! : self
  # end
  def bubble_sort!(&prc)
    prc ||= Proc.new{|a, b|a a <=> b}
    #when we call the prc it will return -1 if left is smaller,
    #0 if equal, and 1 if left is bigger
    sorted = false
    while sorted == false
      sorted = true
      for i in 0..self.length-2
        j = i+1
        if prc.call(self[i], self[j]) == 1
          self[i], self[j] = self[j], self[i]
          sorted = false
        end
      end
    end
    self
  end
  def bubble_sort(&prc)
    sorted = self.dup
    sorted.bubble_sort!
  end
end
# p [4,3,2,5,8, 10].bubble_sort
# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

def substrings(string)
  s = 0
  e = 0
  substrings = []
  while e <= string.length
    # p string[s..e]
    substrings << string[s..e]
    e += 1
    if e == string.length
      s += 1
      e = s
    end
  end
  substrings.uniq
end

def subwords(word, dictionary)
  ss = substrings(word)
  ss.select{|w| dictionary.include?(w)}
end
# p substrings('catinthehat')
# dict = ["cat", "t", "hello"]
# p subwords("catinthehat", dict)
# ### Doubler
# Write a `doubler` method that takes an array of integers and returns an
# array with the original elements multiplied by two.

def doubler(array)
  new_arr = []
  array.each do |e|
    new_arr << e * 2
  end
  new_arr
end

# ### My Each
# Extend the Array class to include a method named `my_each` that takes a
# block, calls the block on every element of the array, and then returns
# the original array. Do not use Enumerable's `each` method. I want to be
# able to write:
#
# ```ruby
# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3
#
# p return_value # => [1, 2, 3]
# ```

class Array
  def my_each(&prc)
    #p prc
    for i in 0..self.length-1
      prc.call self[i]
    end
    self
  end
end
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# p return_value

# ### My Enumerable Methods
# * Implement new `Array` methods `my_map` and `my_select`. Do
#   it by monkey-patching the `Array` class. Don't use any of the
#   original versions when writing these. Use your `my_each` method to
#   define the others. Remember that `each`/`map`/`select` do not modify
#   the original array.
# * Implement a `my_inject` method. Your version shouldn't take an
#   optional starting argument; just use the first element. Ruby's
#   `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
#   up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
#   (and not the symbol) version. Again, use your `my_each` to define
#   `my_inject`. Again, do not modify the original array.
#DO NOT MODIFY ORIGINAL ARRAY!
class Array
  def my_map(&prc)
    new_arr = []
    for element in self
      new_arr << (yield element)
    end
    # self.my_each do |element|
    #   new_arr << (yield element)
    # end
    new_arr
  end

  def my_select(&prc)
    new_arr = []
    for element in self
      if (yield element)
        new_arr << element
      end
    end
    # self.my_each do |element|
    #   if (yield element)
    #     new_arr << element
    #   end
    # end
    new_arr
  end

  def my_inject(&blk)
    accum = self[0]
    self.drop(1).my_each do |element|
      accum = blk.call(accum, element)
    end
    accum
  end
end
p [4,3,2,1].my_inject{|sum, element| sum+=element}
# p [4,3,5,2,1].my_select {|a| a<2}
# p [4,3,5,2,1].select {|a| a<2}
# ### Concatenate
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```

def concatenate(strings)
  #s = strings.dup
  a = ""
  strings.inject(0){|total, word| a<<word}
  a
end
# p concatenate(["a", "b", "c"])
