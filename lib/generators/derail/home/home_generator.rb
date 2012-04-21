module Derail::Generators
  class HomeGenerator < Base
    def generate_controller
      generate "controller", "home", "show"
    end

    def change_route
      gsub_file "config/routes.rb", %{get "home/show"}, %{root to: "home#show"}
    end
  end
end
