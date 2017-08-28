def translate_word(s)
  #starts with vowel
  if vowel?(s[0])
    return s + "ay"
  #starts with consonant sound
  elsif s[0,2] == 'sch'
    return s[2,s.length] + "schay"
  elsif s.include?('qu')
    quindex = s.index('qu')
    firstpart = s[0,quindex+2]
    return s[quindex+2, s.length] + firstpart + "ay"
  #consonant(s)
  else
    vowelidx = index_first_vowel(s)
    return s[vowelidx,s.length]+s[0, vowelidx]+"ay"
  end
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
