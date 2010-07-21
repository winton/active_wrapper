$root = File.expand_path('../../', __FILE__)

require "#{$root}/lib/active_wrapper/gems"

ActiveWrapper::Gems.new(:spec)

require 'pp'
require "#{$root}/lib/active_wrapper"

Spec::Runner.configure do |config|
end

# For use with rspec textmate bundle
def debug(object)
  puts "<pre>"
  puts object.pretty_inspect.gsub('<', '&lt;').gsub('>', '&gt;')
  puts "</pre>"
end