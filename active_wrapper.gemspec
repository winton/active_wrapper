# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
<<<<<<< HEAD:active_wrapper.gemspec
require 'active_wrapper/gems'
ActiveWrapper::Gems.gemset ||= :default

Gem::Specification.new do |s|
  ActiveWrapper::Gems.gemspec.hash.each do |key, value|
    unless %w(dependencies development_dependencies).include?(key)
=======
require 'gem_template/gems'
GemTemplate::Gems.gemset ||= ENV['GEMSET'] || :default

Gem::Specification.new do |s|
  GemTemplate::Gems.gemspec.hash.each do |key, value|
    if key == 'name' && GemTemplate::Gems.gemset != :default
      s.name = "#{value}-#{GemTemplate::Gems.gemset}"
    elsif key == 'summary' && GemTemplate::Gems.gemset == :solo
      s.summary = value + " (no dependencies)"
    elsif !%w(dependencies development_dependencies).include?(key)
>>>>>>> 11fdcaf70ea17e6ea0fdfdd10d997c2e312d32a7:gem_template.gemspec
      s.send "#{key}=", value
    end
  end

<<<<<<< HEAD:active_wrapper.gemspec
  ActiveWrapper::Gems.gemspec.dependencies.each do |g|
    s.add_dependency g.to_s, ActiveWrapper::Gems.versions[g]
  end
  
  ActiveWrapper::Gems.gemspec.development_dependencies.each do |g|
    s.add_development_dependency g.to_s, ActiveWrapper::Gems.versions[g]
=======
  GemTemplate::Gems.dependencies.each do |g|
    s.add_dependency g.to_s, GemTemplate::Gems.versions[g]
  end
  
  GemTemplate::Gems.development_dependencies.each do |g|
    s.add_development_dependency g.to_s, GemTemplate::Gems.versions[g]
>>>>>>> 11fdcaf70ea17e6ea0fdfdd10d997c2e312d32a7:gem_template.gemspec
  end

  s.executables = `git ls-files -- {bin}/*`.split("\n").collect { |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.require_paths = %w(lib)
  s.test_files = `git ls-files -- {features,test,spec}/*`.split("\n")
end