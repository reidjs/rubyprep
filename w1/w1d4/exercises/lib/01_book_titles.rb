class Book
  attr_accessor :title
  def initialize
  end
  def title
    @title = titlize
  end
  def titlize
    titlecase = []
    ignore = [
      'the',
      'and',
      'a',
      'in',
      'of',
      'an',
      'the'
    ]
    @title.split(' ').each_with_index do |word,index|
      word[0] = word[0].upcase if (!ignore.include?(word) || index == 0)
      titlecase << word
    end
    titlecase.join(' ')
  end
end
