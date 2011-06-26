require 'railsex/core_ext/string'

module Railsex
  VERSION = File.read(File.expand_path("../../VERSION", __FILE__)).strip

  extend ActiveSupport::Autoload

  autoload :Engine
  autoload :Generators
  autoload_under :ActiveRecord do
    autoload :Unique
  end
end
