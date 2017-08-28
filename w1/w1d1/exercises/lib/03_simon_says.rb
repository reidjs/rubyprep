def echo(s)
  s
end
def shout(s)
  s.upcase
end
def repeat(s, n=2)
  str = ""
  (n-1).times do
    str += s + " "
  end
  str + s
end
def start_of_word(s, n)
  s[0,n]
end
def first_word(s)
  s.split(" ")[0]
end
def titleize(s)
  ignore = ["and", "the", "over"]
  words = s.split(" ")
  words[0].capitalize! #always cap the first word
  words[1, words.length].each do |w|
    ignore.include?(w) ? nil : w.capitalize!
  end
  words.join(" ")
end
