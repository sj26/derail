require 'derail/core_ext/string'

module Derail
  VERSION = File.read(File.expand_path("../../VERSION", __FILE__)).strip

  extend ActiveSupport::Autoload

  require 'derail/engine'

  autoload :Generators
  autoload_under :ActiveRecord do
    autoload :Unique
  end
end

