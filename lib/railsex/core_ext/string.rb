class String
  def dedent
    indent = lines.reject(&:empty?).map { |line| line.index(/\S/) }.compact.min
    gsub /^ {1,#{indent.to_i}}/, ''
  end unless method_defined? :dedent

  def redent prefix
    prefix = " " * prefix if prefix.is_a? Numeric
    dedent.gsub! /^(?=[ \t]*\S+)/, prefix
  end unless method_defined? :redent
end
