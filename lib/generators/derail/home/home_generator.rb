module Derail::Generators
  class LayoutGenerator < Base
    def generate_controller
      generate "controller", "home", "show"
    end

    def add_route
      insert_into_file "config/routes.rb", <<-ROUTES.redent(2), :before => %r{^end$}
        root :to => "home#show"
      ROUTES
    end
  end
end
