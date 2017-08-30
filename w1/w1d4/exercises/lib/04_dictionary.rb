class Dictionary
  attr_accessor :d
  def initialize
    @d = {}
  end
  def addCollection(arr)
    a = arr.flatten
    @d[a[0]] = a[1]
  end
  def addString(str)
    @d[str] = nil
  end
  def add(obj)
    addString(obj) if obj.class == String
    addCollection(obj) if (obj.class == Array ||
      obj.class == Hash)
  end
  def entries
    @d
  end
  def keywords
    @d.keys.sort
  end
  def include?(keyword)
    keywords.include?(keyword) ? true : false
  end
  def find(keyword)
    found = {}
    @d.keys.each do |k|
      if k.scan(keyword).length > 0
        found[k] = @d[k]
      end
    end
    found
  end
  def printable
    str = ""
    cnt = 0
    temp = @d.keys.sort
    temp.each do |k|
      str += "["+k+"] \""+@d[k]+"\""
      cnt < temp.length-1 ? str += "\n" : nil
      cnt += 1
    end
    str
  end
end
