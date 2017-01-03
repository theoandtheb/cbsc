# -*- encoding: utf-8 -*-
# stub: ginjo-rfm 3.0.11 ruby lib

Gem::Specification.new do |s|
  s.name = "ginjo-rfm"
  s.version = "3.0.11"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bill Richardson", "Geoff Coffey", "Mufaddal Khumri", "Atsushi Matsuo", "Larry Sprock"]
  s.date = "2015-09-17"
  s.description = "Rfm is a standalone database adapter for Filemaker server. Ginjo-rfm features multiple xml parser support, ActiveModel integration, field mapping, compound queries, logging, scoping, and a configuration framework."
  s.email = "http://groups.google.com/group/rfmcommunity"
  s.extra_rdoc_files = ["LICENSE", "README.md", "CHANGELOG.md", "lib/rfm/VERSION"]
  s.files = ["CHANGELOG.md", "LICENSE", "README.md", "lib/rfm/VERSION"]
  s.homepage = "https://github.com/ginjo/rfm"
  s.rdoc_options = ["--line-numbers", "--main", "README.md"]
  s.rubygems_version = "2.5.1"
  s.summary = "Ruby Filemaker adapter"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activemodel>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<diff-lcs>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<ruby-prof>, [">= 0"])
      s.add_development_dependency(%q<libxml-ruby>, [">= 0"])
      s.add_development_dependency(%q<ox>, [">= 0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<activemodel>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<diff-lcs>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<ruby-prof>, [">= 0"])
      s.add_dependency(%q<libxml-ruby>, [">= 0"])
      s.add_dependency(%q<ox>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<diff-lcs>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<ruby-prof>, [">= 0"])
    s.add_dependency(%q<libxml-ruby>, [">= 0"])
    s.add_dependency(%q<ox>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
