# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_wrapper}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Winton Welsh"]
  s.date = %q{2009-07-29}
  s.email = %q{mail@wintoni.us}
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["active_wrapper.gemspec", "gemspec.rb", "lib", "lib/active_wrapper", "lib/active_wrapper/db.rb", "lib/active_wrapper/log.rb", "lib/active_wrapper/mail.rb", "lib/active_wrapper/tasks.rb", "lib/active_wrapper.rb", "MIT-LICENSE", "Rakefile", "README.markdown", "resources", "resources/migration.template", "spec", "spec/active_wrapper", "spec/active_wrapper/db_spec.rb", "spec/active_wrapper/log_spec.rb", "spec/example_project", "spec/example_project/config", "spec/example_project/config/database.yml", "spec/example_project/db", "spec/example_project/db/migrate", "spec/example_project/db/migrate/001_test.rb", "spec/example_project/Rakefile", "spec/spec.opts", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/winton/active_wrapper}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Wraps ActiveRecord and Logger for use in non-Rails environments}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["= 2.3.2"])
      s.add_runtime_dependency(%q<actionmailer>, ["= 2.3.2"])
    else
      s.add_dependency(%q<activerecord>, ["= 2.3.2"])
      s.add_dependency(%q<actionmailer>, ["= 2.3.2"])
    end
  else
    s.add_dependency(%q<activerecord>, ["= 2.3.2"])
    s.add_dependency(%q<actionmailer>, ["= 2.3.2"])
  end
end
