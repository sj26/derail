module Derail::Generators
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

        staging:
          adapter: postgresql
          encoding: unicode
          pool: 5
          database: #{app_slug}_staging
          username: #{app_slug}_staging
          password: #{SecureRandom.hex}

        production:
          adapter: postgresql
          encoding: unicode
          pool: 5
          database: #{app_slug}_production
          username: #{app_slug}_production
          password: #{SecureRandom.hex}
      RUBY
    end

    def configure_staging_environment
      system "cp", "config/environments/production.rb", "config/environments/staging.rb"
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

      inject_into_file "config/environments/staging.rb", <<-RUBY.redent(2), :after => /config.action_mailer.*?\n/

        # Testing URL
        config.action_mailer.default_url_options = { :host => '#{app_slug}.test' }
      RUBY
    end

    def staging_nginx_sendfile
      gsub_file 'config/environments/staging.rb', 'x_sendfile_header = "X-Sendfile"', 'x_sendfile_header = "X-Accel-Redirect"'
    end

    def configure_sass
      inject_into_file "config/application.rb", <<-RUBY.redent(4), :after => /config\.assets[^\n]*\n/

        # Use SASS syntax (not SCSS)
        config.sass.preferred_syntax = :sass
        config.sass.style = :nested
      RUBY

      bundle_run "sass-convert", "app/assets/stylesheets/application.css", "app/assets/stylesheets/application.css.sass"
      remove_file "app/assets/stylesheets/application.css"
    end

    def configure_coffee
      system "mv", "app/assets/javascripts/application.js", "app/assets/javascripts/application.js.coffee"
      gsub_file "app/assets/javascripts/application.js.coffee", %r{^//}, "#"
    end

    def write_htaccess
      create_file "public/.htaccess", <<-HTACCESS.dedent
        # Font MIME types for Apache
        AddType application/vnd.ms-fontobject .eot
        AddType application/octet-stream .otf .ttf
        AddType application/x-font-woff .woff
      HTACCESS
    end

    def disallow_robots
      # Rewrite robots file to disallow indexing until production
      # TODO: Make this smarter... make an engine route in not-production for disallows or override in nginx for staging
      gsub_file "public/robots.txt", %r{^# (\S+:)}, "\\1"
    end

    def clean_routes
      gsub_file "config/routes.rb", %r{^\s*#[^\n]*\n}, ""
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
        bundle_run "guard", "init", guard
      end
    end

    def generate_formtastic
      # TODO: Make optional
      generate "formtastic:install"
    end

    def generate_layouts
      # TODO: Make optional
      generate "derail:layout"
    end

    def generate_home
      # TODO: Home
      # TODO: Make optional
      #generate "derail:home"
    end

    def generate_devise
      # TODO: Make optional
      generate "derail:devise"
    end

    def generate_dashboard
      # TODO: Dashboard
      # TODO: Make optional
      #generate "derail:dashboard"
    end

    def generate_admin
      # TODO: Admin
      # TODO: Make optional
      #generate "derail:admin"
    end

    def generate_pages
      # TODO: Pages
      # TODO: Make optional
      #generate "derail:pages"
    end

    def generate_errors
      # TODO: Error handling
      # TODO: Make optional
      #generate "derail:errors"
    end

    def remove_index
      remove_file "public/index.html"
    end

    def remove_rails_logo
      remove_file "app/assets/images/rails.png"
    end
  end
end
