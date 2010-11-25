require File.dirname(__FILE__) + '/active_wrapper/gems'

ActiveWrapper::Gems.require(:lib)

require 'active_record'
require 'fileutils'
require 'logger'
require 'pony'
require 'yaml'

$:.unshift File.dirname(__FILE__) + '/active_wrapper'

require 'db'
require 'email'
require 'log'
require 'version'

module ActiveWrapper
  class <<self
    
    def setup(options={})
      
      env = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || ENV['MERB_ENV'] || 'development'
      options = {
        :base => File.dirname($0),
        :env => options[:env] || env,
        :log => options[:env] || env
      }.merge(options.reject { |k, v| v.nil? })
      
      db = Db.new(options)
      mail = Email.new(options)
      log = Log.new(options)
      
      [ db, log, mail ]
    end
  end
end

ActiveRecord::Base.default_timezone = :utc