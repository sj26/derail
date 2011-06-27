module Derail::Generators
  class Base < Rails::Generators::Base
    source_root File.expand_path '../../templates'

  protected

    def bundle *args
      say_status :run, "bundle #{args * ' '}"
      system "bundle", *args
    end

    def app_name
      Rails.application.class.parent_name
    end

    def app_slug
      app_name.underscore
    end

    # TODO: Shared bits and pieces
  end
end
