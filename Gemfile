source "http://rubygems.org"

v = {
  :actionmailer => '=2.3.5',
  :activerecord => '=2.3.5',
  :bundler => '=1.0.0.beta.2',
  :rake => '=0.8.7',
  :rspec => '=1.3.0'
}

group :gemspec do
  gem 'bundler', v[:bundler]
end

group :gemspec_dev do
  gem 'rspec', v[:rspec]
end

group :lib do
  gem 'activerecord', v[:activerecord], :require => %w(active_record)
  gem 'actionmailer', v[:actionmailer], :require => %w(action_mailer)
  gem 'mysql'
end

group :rake do
  gem 'rake', v[:rake], :require => %w(rake rake/gempackagetask)
  gem 'rspec', v[:rspec], :require => %w(spec/rake/spectask)
end

group :spec do
  gem 'rspec', v[:rspec], :require => %w(
    spec/adapters/mock_frameworks/rspec
    spec/runner/formatter/progress_bar_formatter
    spec/runner/formatter/text_mate_formatter
  )
end