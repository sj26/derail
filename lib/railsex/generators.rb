module Railsex::Generators
  class Base < Rails::Generators::Base
    source_root File.expand_path '../../templates'

  protected

    def bundle *args
      system Gem.ruby, "-rubygems", Gem.bin_path('bundler', 'bundle'), *args
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
