# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'active_wrapper/gems'
ActiveWrapper::Gems.gemset ||= :default

Gem::Specification.new do |s|
  ActiveWrapper::Gems.gemspec.hash.each do |key, value|
    unless %w(dependencies development_dependencies).include?(key)
      s.send "#{key}=", value
    end
  end

  ActiveWrapper::Gems.gemspec.dependencies.each do |g|
    s.add_dependency g.to_s, ActiveWrapper::Gems.versions[g]
  end
  
  ActiveWrapper::Gems.gemspec.development_dependencies.each do |g|
    s.add_development_dependency g.to_s, ActiveWrapper::Gems.versions[g]
  end

  s.executables = `git ls-files -- {bin}/*`.split("\n").collect { |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.require_paths = %w(lib)
  s.test_files = `git ls-files -- {features,test,spec}/*`.split("\n")
end