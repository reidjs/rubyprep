def reverser(&b)
  # p b.call.reverse
  reversed = []
  b.call.split(' ').each do |w|
    reversed << w.reverse
  end
  reversed.join(' ')
end

def adder(val = 1, &b)
  b.call + val
end

def repeater(val = 1, &b)
  val.times {b.call}
end
