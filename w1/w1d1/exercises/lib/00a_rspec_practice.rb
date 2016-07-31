# The solutions below aren't working.
# Don't read through their code yet;
# run rspec and see if you can pinpoint
# the errors that way!


def predict_relationship(person_a, person_b)
  relations = [
    "hates",
    "despises",
    "will marry",
    "will avenge",
    "is indebted to",
    "loves",
    "will murder"
  ]
  random = rand(2)
  a, b = (random < 1) ? [person_a, person_b] : [person_b, person_a]
  a + relation.sample + b
end

p predict_relationship("Taylor", "Jeffrey")
p predict_relationship("Taylor", "Jeffrey")

def is_perfect_square?(num)
  num.times do |n|
    return true if n**2 = num
  end
  false
end

p is_perfect_square?(4)
p is_perfect_square?(41)
p is_perfect_square?(1)
p is_perfect_square?(16)
