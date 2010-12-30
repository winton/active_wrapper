$root = File.expand_path('../../', __FILE__)

require "#{$root}/lib/active_wrapper/gems"

ActiveWrapper::Gems.gemset = ENV['GEMSET'] if ENV['GEMSET']
ActiveWrapper::Gems.activate :rspec

require "#{$root}/lib/active_wrapper"
require 'pp'

Spec::Runner.configure do |config|
end