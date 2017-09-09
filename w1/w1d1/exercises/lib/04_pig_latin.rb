def translate_word(s)
  uppercase = false
  uppercase = true if s[0].upcase == s[0]
  punctuation = ""
  #store all punctuation
  if s[s.length-1] =~ /[.,!?]/
    punctuation = s[s.length-1]
    s[s.length-1] = ""
  end
  s.downcase!
  str = ''


  #starts with vowel
  if vowel?(s[0])
    str = s + "ay"
  #starts with consonant sound
  elsif s[0,2] == 'sch'
    str = s[2,s.length] + "schay"
    #if there's a qu
  elsif s.include?('qu')
    quindex = s.index('qu')
    firstpart = s[0,quindex+2]
    str = s[quindex+2, s.length] + firstpart + "ay"
  #consonant(s)
  else
    vowelidx = index_first_vowel(s)
    str = s[vowelidx,s.length]+s[0, vowelidx]+"ay"
  end
  str[0] = str[0].upcase! if uppercase
  #add punctuation back in
  str + punctuation
end
#returns the character as vowel or consonant
def vowel?(c)
  !(c =~ /[aeiou]/).nil?
end
def index_first_vowel(s)
  s.chars.each_with_index do |c, i|
    return i if vowel?(c)
  end
  s.length
end
def translate(s)
  words = s.split(' ')
  translated = []
  words.each do |w|
    translated << translate_word(w)
  end
  translated.join(' ')
end
