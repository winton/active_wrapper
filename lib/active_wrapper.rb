require 'rubygems'
require 'bundler'
require 'fileutils'
require 'logger'
require 'yaml'

Bundler.require(:lib)

$:.unshift File.dirname(__FILE__) + '/active_wrapper'

require 'version'

require 'db'
require 'log'
require 'mail'

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
      log = Log.new(options)
      mail = Mail.new(options)
      
      ActionMailer::Base.logger = log
    
      [ db, log, mail ]
    end
  end
end

ActiveRecord::Base.default_timezone = :utc