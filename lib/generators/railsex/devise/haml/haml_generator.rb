module Railsex
  module Generators
    module Devise
      class HamlGenerator < Rails::Generators::Base
        source_root File.expand_path("../devise", __FILE__)

        def copy_views
          directory source, "lib/templates/devise"
        end
      end
    end
  end
end
