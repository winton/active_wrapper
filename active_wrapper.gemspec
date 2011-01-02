# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'gem_template/gems'
ActiveWrapper::Gems.gemset ||= ENV['GEMSET'] || :default

Gem::Specification.new do |s|
  ActiveWrapper::Gems.gemspec.hash.each do |key, value|
    if key == 'name' && ActiveWrapper::Gems.gemset != :default
      s.name = "#{value}-#{ActiveWrapper::Gems.gemset}"
    elsif key == 'summary' && ActiveWrapper::Gems.gemset == :solo
      s.summary = value + " (no dependencies)"
    elsif !%w(dependencies development_dependencies).include?(key)
      s.send "#{key}=", value
    end
  end

  ActiveWrapper::Gems.dependencies.each do |g|
    s.add_dependency g.to_s, ActiveWrapper::Gems.versions[g]
  end
  
  ActiveWrapper::Gems.development_dependencies.each do |g|
    s.add_development_dependency g.to_s, ActiveWrapper::Gems.versions[g]
  end

  s.executables = `git ls-files -- {bin}/*`.split("\n").collect { |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.require_paths = %w(lib)
  s.test_files = `git ls-files -- {features,test,spec}/*`.split("\n")
end