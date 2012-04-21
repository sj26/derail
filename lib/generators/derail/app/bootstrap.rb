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

# The intention here is to bootstrap far enough that we can run some
# of our own generators, but prevent bundling too many times.

in_root do
  say_status :rewrite, "Gemfile"

  puts "Derail running from: #{__FILE__}"
  derail_gemfile_entry = "gem 'derail', :git => 'git://github.com/sj26/derail.git'"
  unless __FILE__ =~ /^https?\:\/\//
    derail_gemfile_entry = "gem 'derail', :path => '#{File.expand_path("../../../../../", __FILE__)}'"
  end

  inject_into_file "Gemfile", <<-RUBY.dedent, :after => rails_gemfile_entry, :verbose => false

    # Rails extensions
    #{derail_gemfile_entry}
  RUBY

  # Get rid of some noise (after rails entry used above)
  gsub_file "Gemfile", /^(^#[^\n]*\n)#[ \t]*gem[^\n]*\n/, "", :verbose => false
  gsub_file "Gemfile", /\n{3,}/, "\n\n", :verbose => false

  if not options[:skip_active_record] and gem_for_database == "pg"
    inject_into_file "Gemfile", "# PostgreSQL is for winners!\n", :before => "gem 'pg'", :verbose => false
    inject_into_file "Gemfile", <<-RUBY.dedent, :after => database_gemfile_entry, :verbose => false
      # Stop PostgreSQL being quite so chatty
      gem 'silent-postgres'
    RUBY
  end

  # The space alignment annoys me SO MUCH
  gsub_file "Gemfile", /(gem 'sass-rails')(?:,\s{2,}(.*))?/, "\\1, \\2"

  inject_into_file "Gemfile", "  gem 'compass-rails'\n", :after => /gem 'sass-rails'.*?\n/, :verbose => false

  gsub_file "Gemfile", /# gem 'therubyracer'/, "gem 'therubyracer', group: [:production, :staging]"

  # TODO: make carrierwave/rmagick optional
  append_file "Gemfile", <<-RUBY.dedent, :verbose => false
    # Views and helpers
    gem 'haml-rails'
    gem 'nestive', :git => 'git://github.com/sj26/nestive.git'
    gem 'formtastic'

    # File uploads with image processing
    gem 'rmagick'
    gem 'carrierwave'

    group :development, :test do
      # Debugging everywhere
      gem 'ruby-debug', :platform => :ruby_18
      gem 'ruby-debug19', :platform => :ruby_19, :require => 'ruby-debug'
    end

    group :test do
      # Testing
      gem 'rspec-rails'
      gem 'shoulda-matchers'
      gem 'simplecov'
      gem 'factory_girl'
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

    # When testing on the mac in guard...
    group :test_mac do
      # Growl for notifications
      gem 'ruby_gntp'

      # FSEvent for efficient file monitoring in
      gem 'rb-fsevent'
    end
  RUBY

  # We need to bundle before continuing
  run "bundle install"

  # Now we do some real work
  run "rails generate derail:app"
end
