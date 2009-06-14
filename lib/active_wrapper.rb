require File.dirname(__FILE__) + "/active_wrapper/db"
require File.dirname(__FILE__) + "/active_wrapper/log"

class ActiveWrapper
  
  def initialize(options={})
    
    options = {
      :base => File.dirname($0),
      :env => 'development',
      :log => 'development'
    }.merge(options)
    
    [ Db.new(options), Log.new(options) ]
  end
end