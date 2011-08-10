class HtmlInput < Formtastic::Inputs::TextInput
  def input_html_options
    super.merge :class => "html"
  end
end