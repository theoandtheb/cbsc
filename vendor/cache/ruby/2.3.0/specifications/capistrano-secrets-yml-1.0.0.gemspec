# -*- encoding: utf-8 -*-
# stub: capistrano-secrets-yml 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-secrets-yml"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bruno Sutic"]
  s.date = "2014-10-07"
  s.description = "Capistrano tasks for automating `secrets.yml` file handling for Rails 4+ apps.\nThis plugins syncs contents of your local secrets file and copies that to\nthe remote server.\n"
  s.email = ["bruno.sutic@gmail.com"]
  s.homepage = "https://github.com/capistrano-plugins/capistrano-secrets-yml"
  s.rubygems_version = "2.5.1"
  s.summary = "Capistrano tasks for automating `secrets.yml` file handling for Rails 4+ apps."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 3.1"])
      s.add_runtime_dependency(%q<sshkit>, [">= 1.2.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, [">= 3.1"])
      s.add_dependency(%q<sshkit>, [">= 1.2.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 3.1"])
    s.add_dependency(%q<sshkit>, [">= 1.2.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
