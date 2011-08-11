module Derail::Generators
  class LayoutGenerator < Base
    source_root File.expand_path("../../../../templates/layout", __FILE__)

    def remove_erb
      remove_file "app/views/layout/application.erb.rb"
    end

    def copy_haml_layouts
      copy_file "application.html.haml", "app/views/layout/application.html.haml"
      copy_file "canvas.html.haml", "app/views/layout/canvas.html.haml"
    end
  end
end
