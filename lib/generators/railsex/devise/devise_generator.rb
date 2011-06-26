module Railsex::Generators
  class DeviseGenerator < Base
    def install_devise
      inject_into_file "Gemfile", <<-RUBY.dedent, :before => "group :development"
        # Authentication
        # FIXME: Until at least controller inheritence is available
        gem "devise", :github => "sj26/devise", :branch => "template-inheritence"
      RUBY

      bundle
    end

    def generate_devise
      generate "devise:install"
      generate "devise", "user"
      generate "railsex:devise:haml"
    end
  end
end
