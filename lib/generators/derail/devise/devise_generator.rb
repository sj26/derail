module Derail::Generators
  class DeviseGenerator < Base
    def install_devise
      inject_into_file "Gemfile", <<-RUBY.dedent, :before => "group :development"
        # Authentication
        # FIXME: Until at least controller inheritence is available
        gem 'devise', :git => 'git://github.com/sj26/devise.git', :branch => 'template-inheritence'

      RUBY

      inject_into_file "Gemfile", <<-RUBY.dedent, :after => /gem (['"])remarkable_activerecord\1[^\n]*\n/
        gem 'remarkable_devise', :git => 'git://github.com/sj26/remarkable_devise.git'
      RUBY

      bundle "install"
    end

    def generate_devise
      generate "devise:install"
      generate "devise", "user"
      generate "derail:devise:haml"
    end
  end
end
