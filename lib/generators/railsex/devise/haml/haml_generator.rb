module Railsex
  module Generators
    module Devise
      class HamlGenerator < Rails::Generators::Base
        source_root File.expand_path("../../../../../templates/devise/haml", __FILE__)

        def copy_views
          directory "views", "app/views/devise"
        end
      end
    end
  end
end
