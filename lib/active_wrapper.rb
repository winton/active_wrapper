require 'rubygems'
require 'activerecord'
require 'logger'
require 'yaml'

require File.dirname(__FILE__) + "/active_wrapper/db"
require File.dirname(__FILE__) + "/active_wrapper/log"

module ActiveWrapper
  class <<self
    
    def setup(options={})
      
      options = {
        :base => File.dirname($0),
        :env => 'development',
        :log => 'development'
      }.merge(options.reject { |k, v| v.nil? })
    
      [ Db.new(options), Log.new(options) ]
    end
  end
end

ActiveRecord::Base.default_timezone = :utc