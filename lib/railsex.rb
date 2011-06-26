require 'railsex/core_ext'

module Railsex
  VERSION = File.read(File.expand_path("../../VERSION", __FILE__)).strip

  extend ActiveSupport::Autoload

  autoload :Engine
  autoload :Generator
end
