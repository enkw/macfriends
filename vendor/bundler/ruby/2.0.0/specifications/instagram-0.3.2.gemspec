# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "instagram"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mislav Marohni\u{c4}\u{87}"]
  s.date = "2011-01-28"
  s.description = "Ruby library for consuming the Instagram public API."
  s.email = "mislav.marohnic@gmail.com"
  s.homepage = "http://github.com/mislav/instagram"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Instagram API client"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>, [">= 0"])
      s.add_runtime_dependency(%q<yajl-ruby>, [">= 0"])
      s.add_runtime_dependency(%q<nibbler>, [">= 1.2.0"])
    else
      s.add_dependency(%q<addressable>, [">= 0"])
      s.add_dependency(%q<yajl-ruby>, [">= 0"])
      s.add_dependency(%q<nibbler>, [">= 1.2.0"])
    end
  else
    s.add_dependency(%q<addressable>, [">= 0"])
    s.add_dependency(%q<yajl-ruby>, [">= 0"])
    s.add_dependency(%q<nibbler>, [">= 1.2.0"])
  end
end
