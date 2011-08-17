module LayoutHelper
  def default_application_name
    Rails.application.class.name.split('::').first
  end

  def application_name
    @application_name ||= t :application_name, :default => proc { default_application_name.titleize }
  end

  def classical_application_name
    @classical_application_name ||= default_application_name.underscore.dasherize
  end

  def modular_controller_name
    @modular_controller_name ||= controller.class.name.sub(/Controller$/, '').underscore.dasherize
  end

  def modular_controller_ancestor_names
    @modular_controller_ancestor_names ||= (controller.class.ancestors - [controller.class]).find_all { |klass| klass.name =~ /Controller$/ }.map { |klass| klass.name.sub(/Controller$/, "").underscore.dasherize }
  end

  def body_classes
    @body_classes ||= [
      classical_application_name.underscore.dasherize,
      modular_controller_name.parameterize,
      modular_controller_ancestor_names.map(&:parameterize),
      [modular_controller_name, action_name].join('-').parameterize,
      ([modular_controller_name, action_name, params[:id]].join('-').parameterize if params[:id].present?),
      with_sidebar_class,
    ].flatten.compact
  end

  def title
    [area(:title).presence, application_name].compact.join ' - '
  end

  # TODO: Expand into feature or area classes...
  def with_sidebar_class
    ('with-sidebar' if area(:sidebar).present?)
  end

  def classy_words words
    safe_join words.split(/\s+/).map { |word| content_tag(:span, word, :class => word.parameterize) }, " "
  end
end
