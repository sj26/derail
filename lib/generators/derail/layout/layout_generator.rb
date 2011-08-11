module Derail::Generators
  class LayoutGenerator < Base
    source_root File.expand_path("../../../../templates/layout", __FILE__)

    def install_haml_rails
      insert_into_file "Gemfile", "gem 'haml-rails'\n", :after => "# Views helpers\n"

      bundle_install
    end

    def remove_erb
      remove_file "app/views/layouts/application.erb.rb"
    end

    def copy_haml_layouts
      copy_file "application.html.haml", "app/views/layouts/application.html.haml"
      copy_file "canvas.html.haml", "app/views/layouts/canvas.html.haml"
    end
  end
end
