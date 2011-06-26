# This gets read via HTTP as a single file then executed in the app
# generator instance, so everything needs to be bundled in here.

# TODO: Sprockets require to include library files or some fancy shiznit.

class ::String
  def dedent
    indent = lines.reject(&:empty?).map { |line| line.index(/\S/) }.compact.min
    gsub /^ {1,#{indent.to_i}}/, ''
  end unless method_defined? :dedent

  def redent prefix
    prefix = " " * prefix if prefix.is_a? Numeric
    dedent.gsub! /^(?=[ \t]*\S+)/, prefix
  end unless method_defined? :redent
end

unless Gem.available? "bundler", ">=1.1.pre"
  raise "You need at least bundler 1.1 so we can GitHub in our Gemfile. It's still in pre-release, so install with:\n\n  gem install bundler --pre"
end

# The intention here is to bootstrap far enough that we can run some
# of our own generators.

in_root do
  say_status :rewrite, "Gemfile"

  inject_into_file "Gemfile", <<-RUBY.dedent, :after => rails_gemfile_entry, :verbose => false

    # Rails extensions
    gem 'railsex', :github => 'sj26/railsex'
  RUBY

  if not options[:skip_active_record] and gem_for_database == "pg"
    inject_into_file "Gemfile", "# PostgreSQL is for winners!\n", :before => "gem 'pg'", :verbose => false
    inject_into_file "Gemfile", <<-RUBY.dedent, :after => database_gemfile_entry, :verbose => false
      # Stop PostgreSQL being quite so chatty
      gem 'silent-postgres'
    RUBY
  end

  inject_into_file "Gemfile", <<-RUBY.rstrip.dedent, :after => "# Asset template engines", :verbose => false
     and helpers
    gem 'haml-rails'
  RUBY

  inject_into_file "Gemfile", <<-RUBY.dedent, :after => "gem 'sass-rails'.*?\n", :verbose => false
    gem "compass", :github => "sj26/compass", :branch => "rails31"
  RUBY

  inject_into_file "Gemfile", <<-RUBY.dedent, :after => "gem 'coffee-script'.*?\n", :verbose => false
    gem "therubyracer"
  RUBY

  # Cut the crap from the end
  gsub_file "Gemfile", /# Use unicorn.*\Z/, "", :verbose => false

  append_file "Gemfile", <<-RUBY.dedent, :verbose => false
    # Views helpers
    gem 'nestive', :github => 'sj26/nestive'
    gem 'formtastic', '~> 2.0.0.rc2'

    group :development, :test do
      # Debugging everywhere
      gem 'ruby-debug', :platform => :ruby_18
      gem 'ruby-debug19', :platform => :ruby_19, :require => 'ruby-debug'

      # Testing
      gem 'rspec-rails'
      gem 'rcov'
      gem 'rr'
      gem 'factory_girl', '~> 2.0.0.beta2'
      gem 'ffaker'

      # Acceptance testing
      gem 'cucumber-rails'

      # Continuous testing/building
      gem 'guard'
      gem 'guard-ego'
      gem 'guard-bundler'
      gem 'guard-rspec'
      gem 'guard-cucumber'
    end

    group :test do
      # Remarkable matchers for terse and expressive specs
      gem 'remarkable'
      gem 'remarkable_activerecord'
      gem 'remarkable_devise', :github => 'sj26/remarkable_devise'
    end

    # When testing on the mac in guard...
    group :test_mac do
      # Growl for notifications
      gem 'growl'

      # FSEvent for efficient file monitoring in
      gem 'rb-fsevent'
    end
  RUBY

  # Add action mailer defaults
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

  # Write rvmrc
  rvm_string = ENV["rvm_ruby_string"] || ""
  rvm_string += "@#{ENV["rvm_gemset_name"]}" if ENV["rvm_gemset_name"].present?
  if rvm_string.present?
    create_file ".rvmrc", <<-RVMRC.dedent
      rvm #{rvm_string} --create
    RVMRC
  end
end
