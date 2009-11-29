Dir["#{File.dirname(__FILE__)}/../vendor/*/lib"].each do |path|
  $:.unshift path
end

require 'rubygems'
gem 'activerecord', '=2.3.5'
gem 'actionmailer', '=2.3.5'
require 'active_record'
require 'action_mailer'
require 'logger'
require 'yaml'

require File.dirname(__FILE__) + "/active_wrapper/db"
require File.dirname(__FILE__) + "/active_wrapper/log"
require File.dirname(__FILE__) + "/active_wrapper/mail"

module ActiveWrapper
  class <<self
    
    def setup(options={})
      
      options = {
        :base => File.dirname($0),
        :env => 'development',
        :log => options[:env] || 'development'
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