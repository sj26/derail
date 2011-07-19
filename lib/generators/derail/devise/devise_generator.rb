module Derail::Generators
  class DeviseGenerator < Base
    def install_devise
      inject_into_file "Gemfile", <<-RUBY.dedent, :before => "group :development"
        # Authentication
        # FIXME: Until at least controller inheritence is available
        gem 'devise', :git => 'git://github.com/sj26/devise.git', :branch => 'template-inheritence'

      RUBY

      inject_into_file "Gemfile", <<-RUBY.redent(2), :after => /gem (['"])remarkable_activerecord\1[^\n]*\n/
        gem 'remarkable_devise', :git => 'git://github.com/sj26/remarkable_devise.git'
      RUBY

      bundle "install"
    end

    def generate_devise
      generate "devise:install"
      generate "devise", "user"
      generate "derail:devise:haml";
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
