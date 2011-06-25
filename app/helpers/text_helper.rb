require "hpricot"

# Adapted from http://henrik.nyh.se/2008/01/rails-truncate-html-helper

module TextHelper
  # Like the Rails _truncate_ helper but doesn't break HTML tags or entities.
  def truncate_html(text, options={})
    return if text.nil?

    length = options.delete(:length) || 30
    omission = options.delete(:omission).to_s || "..."
    text = text.to_s

    document = Hpricot(text)
    omission_length = Hpricot(omission).inner_text.chars.count
    content_length = document.inner_text.chars.count

    content_length > length ? document.truncate([length - omission_length, 0].max).inner_html + omission : text
  end
end

module HpricotTruncator
  module NodeWithChildren
    def truncate(length)
      return self if inner_text.chars.count <= length
      truncated_node = self.dup
      truncated_node.children = []
      each_child do |node|
        remaining_length = length - truncated_node.inner_text.chars.count
        break if remaining_length == 0
        truncated_node.children << node.truncate(remaining_length)
      end
      truncated_node
    end
  end

  module TextNode
    def truncate(length)
      # We're using String#scan because Hpricot doesn't distinguish entities.
      Hpricot::Text.new(content.scan(/&#?[^\W_]+;|./).first(length).join)
    end
  end

  module IgnoredTag
    def truncate(length)
      self
    end
  end
end

Hpricot::Doc.send(:include,       HpricotTruncator::NodeWithChildren)
Hpricot::Elem.send(:include,      HpricotTruncator::NodeWithChildren)
Hpricot::Text.send(:include,      HpricotTruncator::TextNode)
Hpricot::BogusETag.send(:include, HpricotTruncator::IgnoredTag)
Hpricot::Comment.send(:include,   HpricotTruncator::IgnoredTag)
