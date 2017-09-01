require_relative 'course'
class Student
  attr_accessor :first_name, :last_name, :courses
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  def enroll(c)
    courses << c
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
