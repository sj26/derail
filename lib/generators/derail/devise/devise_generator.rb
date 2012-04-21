module Derail::Generators
  class DeviseGenerator < Base
    def install_devise
      inject_into_file "Gemfile", <<-RUBY.dedent, :before => "group :development"
        # Authentication
        gem 'devise'

      RUBY

      bundle_install
    end

    def generate_devise
      generate "devise:install"
      generate "devise", "user"
      generate "derail:devise:haml"
    end

    def insert_global_routes
      # TODO
      <<-RUBY.redent(2)
        # Devise routes
        devise_for :users, :skip => [:sessions, :registrations] do
          # Override some notable routes to be simpler
          get 'sign_in' => 'devise/sessions#new', :as => :new_user_session
          post 'sign_in' => 'devise/sessions#create', :as => :user_session

          get 'sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session

          get 'sign_up' => 'devise/registrations#new', :as => :new_user_registration
          post 'sign_up' => 'devise/registrations#create', :as => :user_registration
        end
      RUBY
    end
  end
end
