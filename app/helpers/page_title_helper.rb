module PageTitleHelper
  def page_title *args
    options = args.extract_options!
    if args.present?
      @page_title = args
    else
      @page_title ||= begin
        defaults = [:title]

        if try(:resource).present?
          resource_name = resource.class.name.underscore
          defaults.unshift :"#{resource_name}.title"
          if resource_param = resource.try(:to_param)
            defaults.unshift :"#{resource_name}.#{resource_param}.title"
          end
        end

        if try(:resource_scope).present?
          resource_scope_name = resource_scope.class.name.underscore
          defaults.unshift *defaults.map { |default| [resource_scope_name, default].compact.join('.').to_sym }
        end

        view_context.t defaults.shift,
          :defaults => defaults + ["%{resource}"],
          :resource => resource,
          :resource_scope => resource_scope
      end
    end
  end
end
