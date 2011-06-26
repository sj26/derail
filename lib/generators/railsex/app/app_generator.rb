require 'railsex'

class Railsex::Generator::AppGenerator < Railsex::Generator
  def configure_action_mailer
    inject_into_file "config/environments/development.rb", <<-RUBY.redent(2), :after => /config.action_mailer.*?\n/

      # Development URL
      config.action_mailer.default_url_options = { :host => '#{app_const_base.underscore}.dev' }

      # Send mail via MailCatcher
      config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025 }
    RUBY

    inject_into_file "config/environments/test.rb", <<-RUBY.redent(2), :after => /config.action_mailer.*?\n/

      # Testing URL
      config.action_mailer.default_url_options = { :host => '#{app_const_base.underscore}.test' }
    RUBY
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
      run "guard init #{guard}"
    end
  end

  def generate_layouts
    # TODO: Layouts
    # TODO: Make optional
    #generate "railsex:layout"
  end

  def generate_devise
    # TODO: Devise
    # TODO: Make optional
    #generate "railsex:devise"
  end

  def generate_home
    # TODO: Home
    # TODO: Make optional
    #generate "railsex:home"
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
end
