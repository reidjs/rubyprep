require_relative 'course'
require 'byebug'
class Student
  attr_accessor :first_name, :last_name, :courses
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  def enroll(c)
    @courses.each do |e|
      raise "Conflict with other course." if e.conflicts_with?(c)
    end
    @courses << c if !@courses.include?(c)
    c.students << self if !c.students.include?(self)
  end
  def name
    @first_name + " " + @last_name
  end
  def course_load
    h = {}
    @courses.each do |c|
      h.keys.include?(c.department) ?
          h[c.department] += c.credits :
          h[c.department] = c.credits
    end
    h
  end
end
# s = Student.new("Johnny", "Rocket")
# p s.first_name
# c = Course.new("Ruby 101", "CS", 4)
# c.add_student(s)
# c.add_student(s)
#
# s.courses.each do |c|
#   p c.name
# end
