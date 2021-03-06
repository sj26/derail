module Derail::Generators
  class LayoutGenerator < Base
    source_root File.expand_path("../../../../templates/layout", __FILE__)

    def remove_erb
      remove_file "app/views/layouts/application.html.erb"
    end

    def copy_sass_layout
      # Yes, we *do* want to override
      remove_file "app/assets/stylesheets/application.css.sass"
      copy_file "application.css.sass", "app/assets/stylesheets/application.css.sass"
    end

    def copy_haml_layouts
      copy_file "application.html.haml", "app/views/layouts/application.html.haml"
      copy_file "canvas.html.haml", "app/views/layouts/canvas.html.haml"
    end

    def insert_layout_into_application_controller
      insert_into_file "app/controllers/application_controller.rb", "\n\n  layout 'canvas'", :before => "\nend"
    end
  end
end
