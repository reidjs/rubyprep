# Sum
#
# Write an Array method, `sum`, that returns the sum of the elements in the
# array. You may assume that all of the elements are integers.

class Array
  def sum
    self.inject(0,:+)
  end
end

# Square
#
# Write an array method, `square`, that returns a new array containing the
# squares of each element. You should also implement a "bang!" version of this
# method, which mutates the original array.

class Array
  def square!
    self.map!{|e|e**2}
  end

  def square
    self.dup.map{|e|e**2}
  end
end

# Finding Uniques
#
# Monkey-patch the Array class with your own `uniq` method, called
# `my_uniq`. The method should return the unique elements, in the order
# they first appeared:
#
# ```ruby
# [1, 2, 1, 3, 3].my_uniq # => [1, 2, 3]
# ```
#
# Do not use the built-in `uniq` method!

class Array
  def my_uniq
    arr = []
    self.each do |e|
      if !arr.include?(e)
        arr << e
      end
    end
    arr
  end
end

# Two Sum
#
# Write a new `Array#two_sum` method that finds all pairs of positions
# where the elements at those positions sum to zero.
#
# NB: ordering matters. I want each of the pairs to be sorted smaller
# index before bigger index. I want the array of pairs to be sorted
# "dictionary-wise":
#
# ```ruby
# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# ```
#
# * `[0, 2]` before `[1, 2]` (smaller first elements come first)
# * `[0, 1]` before `[0, 2]` (then smaller second elements come first)

class Array
  def two_sum
    pairs = []
    idx1 = 0
    idx2 = 1
    while idx2 < self.length
      sum = self[idx1] + self[idx2]
      if sum == 0
        pairs << [idx1, idx2]
      end
      idx2 += 1
      if idx2 == self.length
        idx1 += 1
        idx2 = idx1 + 1
      end
    end
    pairs
  end
end

# Median
#
# Write a method that finds the median of a given array of integers. If
# the array has an odd number of integers, return the middle item from the
# sorted array. If the array has an even number of integers, return the
# average of the middle two items from the sorted array.

class Array
  def median
    sorted = self.sort
    l = sorted.length
    if l < 1
      return nil
    elsif l % 2 == 0
      p ((sorted[l/2]+sorted[l/2 - 1]).to_f / 2.0)
      return ((sorted[l/2]+sorted[l/2 - 1]).to_f / 2.0)
    else
      return sorted[l/2]
    end
  end
end

# My Transpose
#
# To represent a *matrix*, or two-dimensional grid of numbers, we can
# write an array containing arrays which represent rows:
#
# ```ruby
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]
#
# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# ```
#
# We could equivalently have stored the matrix as an array of
# columns:
#
# ```ruby
# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# ```
#
# Write a method, `my_transpose`, which will convert between the
# row-oriented and column-oriented representations. You may assume square
# matrices for simplicity's sake. Usage will look like the following:
#
# ```ruby
# matrix = [
#   [0, 1, 2],
#   [3, 4, 5],
#   [6, 7, 8]
# ]
#
# matrix.my_transpose
#  # => [[0, 3, 6],
#  #    [1, 4, 7],
#  #    [2, 5, 8]]
# ```
#
# Don't use the built-in `transpose` method!

class Array
  def my_transpose
    tr = []
    self.length.times do
      tr << []
    end
    idx = 0
    self.each do |arr|
      arr.each do |v|
        #p v
        tr[idx] << v
        idx+=1
      end
      idx=0
    end
    tr
  end
  def my_transpose_bonus
    tr = []
    self[0].length.times do
      tr << []
    end
    idx = 0
    self.each do |arr|
      arr.each do |v|
        tr[idx] << v
        idx+=1
      end
      idx=0
    end
    #self.transpose
    tr
  end
end

# Bonus: Refactor your `Array#my_transpose` method to work with any rectangular
# matrix (not necessarily a square one).
