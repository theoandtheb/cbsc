# -*- encoding: utf-8 -*-
# stub: rgeo-geojson 0.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rgeo-geojson"
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Daniel Azuma", "Tee Parham"]
  s.date = "2016-04-05"
  s.description = "Convert RGeo data to and from GeoJSON. rgeo-geojson is an extension to the rgeo gem that converts RGeo data types to and from GeoJSON."
  s.email = ["dazuma@gmail.com", "parhameter@gmail.com"]
  s.homepage = "https://github.com/rgeo/rgeo-geojson"
  s.licenses = ["BSD"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.5.1"
  s.summary = "Convert RGeo data to and from GeoJSON."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rgeo>, ["~> 0.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<minitest>, ["~> 5.8"])
      s.add_development_dependency(%q<rake>, ["~> 11.0"])
    else
      s.add_dependency(%q<rgeo>, ["~> 0.5"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<minitest>, ["~> 5.8"])
      s.add_dependency(%q<rake>, ["~> 11.0"])
    end
  else
    s.add_dependency(%q<rgeo>, ["~> 0.5"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<minitest>, ["~> 5.8"])
    s.add_dependency(%q<rake>, ["~> 11.0"])
  end
end
