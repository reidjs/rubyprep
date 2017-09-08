class XmlDocument
  @@indent = false
  @@indentation_level = 0
  def initialize(indent=false)
    @@indent = indent
  end
  def method_missing(*args, &b)
    @@indent ? tags = render_tags_with_indentation(args[0], args[1], &b) : tags = render_tags(args[0], args[1], &b)
    p "#{tags}"

  end
  def render_tags(tag, attributes, &b)
    # p yield if block_given?
    s = []
    if attributes.nil?
      s << "<#{tag}"
    else
      s << "<#{tag} #{attributes.keys.first}=\"#{attributes.values.first}\""
    end
    if block_given?
      s << ">"
      s << yield
      s << "</#{tag}>"
    else
      s << "/>"
    end
    s.join
  end
  def render_tags_with_indentation(tag, attributes, &b)
    # p yield if block_given?
    s = []
    if attributes.nil?
      s << " "*@@indentation_level
      s << "<#{tag}"
      @@indentation_level += 2
    else
      s << " "*@@indentation_level
      s << "<#{tag} #{attributes.keys.first}=\"#{attributes.values.first}\""
      @@indentation_level += 2
    end
    if block_given?
      s << ">\n"
      s << yield
      s << " "*@@indentation_level
      s << "</#{tag}>\n"
      @@indentation_level -= 2
    else
      s << "/>\n"
      @@indentation_level -= 4
    end
    s.join
  end
end
