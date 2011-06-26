module Railsex::Generators
  class AppGenerator < Base
    def configure_database
      # The original is full of noise, ick.
      remove_file "config/database.yml", :verbose => false
      create_file "config/database.yml", <<-RUBY.dedent
        development:
          adapter: postgresql
          encoding: unicode
          pool: 5
          database: #{app_slug}_development
          username: development
          password: development

        test:
          adapter: postgresql
          encoding: unicode
          pool: 5
          database: #{app_slug}_test
          username: test
          password: test

        production:
          adapter: postgresql
          encoding: unicode
          pool: 5
          database: \#{ENV["DATABASE"]}
          username: \#{ENV["DATABASE_USERNAME"]}
          password: \#{ENV["DATABASE_PASSWORD"]}
      RUBY
    end

    def configure_action_mailer
      inject_into_file "config/environments/development.rb", <<-RUBY.redent(2), :after => /config.action_mailer.*?\n/

        # Development URL
        config.action_mailer.default_url_options = { :host => '#{app_slug}.dev' }

        # Send mail via MailCatcher
        config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025 }
      RUBY

      inject_into_file "config/environments/test.rb", <<-RUBY.redent(2), :after => /config.action_mailer.*?\n/

        # Testing URL
        config.action_mailer.default_url_options = { :host => '#{app_slug}.test' }
      RUBY
    end

    def configure_sass
      inject_into_file "config/application.rb", <<-RUBY.redent(4), :after => /config\.assets[^\n]*\n/

        # Use SASS by default
        config.generators.stylesheet_engine = :sass
      RUBY

      bundle "exec", "sass-convert", "app/assets/stylesheets/application.css", "app/assets/stylesheets/application.css.sass"
      remove_file "app/assets/stylesheets/application.css"
    end

    def configure_coffee
      system "mv", "app/assets/javascripts/application.js", "app/assets/javascripts/application.js.coffee"
      gsub_file "app/assets/javascripts/application.js.coffee", %r{^//}, "#"
    end

    def install_rspec
      # TODO: Make optional
      generate "rspec:install"
    end

    def install_cucumber
      # TODO: Make optional
      generate "cucumber:install"
    end

    def install_rr
      gsub_file "spec/spec_helper.rb", /[ \t]*# == Mock Framework\n(.*)\n[ \t]*config\.mock_with[ \t]*\S+\n/m, <<-RUBY.redent(2)
        # == Mock Framework
        config.mock_with :rr
      RUBY

      # TODO: Insert RR cucumber support
    end

    def install_guard
      # TODO: Make optional
      say_status :create, "Guardfile"
      ["ego", "bundler", "rspec", "cucumber"].each do |guard|
        bundle "exec", "guard", "init", guard
      end
    end

    def generate_layouts
      # TODO: Layouts
      # TODO: Make optional
      #generate "railsex:layout"
    end

    def generate_home
      # TODO: Home
      # TODO: Make optional
      #generate "railsex:home"
    end

    def generate_devise
      # TODO: Make optional
      generate "railsex:devise"
    end

    def generate_dashboard
      # TODO: Dashboard
      # TODO: Make optional
      #generate "railsex:dashboard"
    end

    def generate_admin
      # TODO: Admin
      # TODO: Make optional
      #generate "railsex:admin"
    end

    def generate_pages
      # TODO: Pages
      # TODO: Make optional
      #generate "railsex:pages"
    end

    def generate_errors
      # TODO: Error handling
      # TODO: Make optional
      #generate "railsex:errors"
    end

    def remove_index
      remove_file "public/index.html"
    end

    def remove_rails_logo
      remove_file "app/assets/images/rails.png"
    end
  end
end
