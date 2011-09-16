module Derail::Generators
  class Base < Rails::Generators::Base
    source_root File.expand_path '../../templates'

  protected

    # Adapted from escape gem
    def shell_escape *words
      words.map do |word|
        if word.empty?
          "''"
        elsif %r{\A[0-9A-Za-z+,./:=@_-]+\z} =~ word
          word
        else
          word.scan(/('+)|[^']+/).map do
            if $1
              %q{\'} * $1.length
            else
              "'#{$&}'"
            end
          end.join
        end
      end.join " "
    end

    def bundle *args
      options = args.extract_options!
      in_root { run shell_escape("bundle", *args), options }
    end

    def bundle_install
      begin
        # XXX: Something puts "-rbundler/setup" in RUBYOPT, bad.
        old_rubyopt = ENV.delete 'RUBYOPT'
        bundle "install"
      ensure
        ENV['RUBYOPT'] = old_rubyopt
      end
    end

    def bundle_run *args
      args << args.extract_options!.merge(:verbose => false)
      bundle "exec", *args
    end

    # Override generate to run in bundle
    def generate *args
      say_status :generate, args * " "
      bundle_run "rails", "generate", *args
    end

    def app_name
      Rails.application.class.parent_name
    end

    def app_slug
      app_name.underscore
    end
  end
end
