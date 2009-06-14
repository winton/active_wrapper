require File.expand_path("#{File.dirname(__FILE__)}/../active_wrapper")

module ActiveWrapper
  class Tasks
    
    def initialize(options={}, &block)
      
      task :environment do
        $db, $log = ActiveWrapper.setup(options)
        $db.establish_connection
        yield if block
      end
      
      namespace :db do
        desc "Migrate the database with optional VERSION"
        task :migrate => :environment do
          $db.migrate(ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
        end
      end
      
      namespace :generate do
        desc "Generate a migration with given NAME"
        task :migration => :environment do
          $db.generate_migration(ENV['NAME'])
        end
      end
      
      namespace :log do
        desc "Clear all logs"
        task :clear => :environment do
          $log.clear
        end
      end
    end
  end
end