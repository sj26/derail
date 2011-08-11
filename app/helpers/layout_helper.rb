module LayoutHelper
  def modular_controller_name
    @modular_controller_name ||= controller.class.name.sub(/Controller$/, '').underscore.dasherize
  end

  def body_classes
    @body_classes ||= [
      (@@body_class_app ||= Rails.application.class.name.parameterize),
      modular_controller_name.parameterize,
      [modular_controller_name, action_name].join('-').parameterize,
      ([modular_controller_name, action_name, params[:id]].join('-').parameterize if params[:id].present?),
      with_sidebar_class,
    ].compact
  end

  def title
    [area(:title).presence, "Career Finder"].compact.join ' - '
  end

  def with_sidebar_class
    ('with-sidebar' if area(:sidebar).present?)
  end

  def classy_words words
    safe_join words.split(/\s+/).map { |word| content_tag(:span, word, :class => word.parameterize) }, " "
  end
end
