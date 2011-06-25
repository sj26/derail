Gem::Specification.new do |s|
  s.name = "railsex"
  s.version = File.read(File.expand_path("../VERSION", __FILE__)).strip
  s.platform    = Gem::Platform::RUBY
  s.summary = "sj26's collection of rails bits and pieces."
  s.description = <<-END
    Railsex is a collection of helpers and libraries which I use
    in in almost every project.
  END

  s.author = "Samuel Cochran"
  s.email = "sj26@sj26.com"
  s.homepage = "https://github.com/sj26/railsex"

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = "lib"
  s.extra_rdoc_files = ["README.md", "LICENSE"]

  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency "railties", ">= 3.1.rc4"
  s.add_dependency "formtastic", ">= 2.0.0.rc3"

  s.add_development_dependency "sass", "~> 3.1"
  s.add_development_dependency "compass", "~> 0.11.1"
  s.add_development_dependency "coffee-script", "~> 2.2"
end
