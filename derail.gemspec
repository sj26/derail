Gem::Specification.new do |s|
  s.name = "derail"
  s.version = File.read(File.expand_path("../VERSION", __FILE__)).strip
  s.platform    = Gem::Platform::RUBY
  s.summary = "sj26's collection of rails bits and pieces."
  s.description = <<-END
    Derail is a collection of helpers and libraries which I use in
    almost every project, and a generator to get started quickly.
  END

  s.author = "Samuel Cochran"
  s.email = "sj26@sj26.com"
  s.homepage = "https://github.com/sj26/derail"

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = "lib"
  s.extra_rdoc_files = ["README.md", "LICENSE"]

  s.required_ruby_version = '>= 1.8.7'

  s.add_dependency "railties", ">= 3.1.rc4"
  s.add_dependency "formtastic", ">= 2.0.0.rc3"
  s.add_dependency "hpricot"
end
