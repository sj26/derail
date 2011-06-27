module Derail::Generators
  class Base < Rails::Generators::Base
    source_root File.expand_path '../../templates'

  protected

    def rvm *args
      options = args.extract_options!
      say_status :run, "rvm #{args * " "}" # unless options[:verbose] === false
      system (["rvm"] + args) * " "
    end

    def rvm_run *args
      args << args.extract_options!.merge(:verbose => false)
      rvm "--with-rubies", "default-with-rvmrc", "exec", *args
    end

    def bundle *args
      options = args.extract_options!
      say_status :run, "bundle #{args * " "}" # unless options[:verbose] === false
      rvm_run "bundle", *args
    end

    def bundle_run *args
      args << args.extract_options!.merge(:verbose => false)
      bundle "exec", *args
    end

    # Override run to run in our rvm/bundle
    alias run bundle_run

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
