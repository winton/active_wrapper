require File.expand_path("#{File.dirname(__FILE__)}/../active_wrapper")

module ActiveWrapper
  class Tasks
    
    def initialize(options={}, &block)
      
      task :environment do
        $db, $log = ActiveWrapper.setup(options)
        yield if block
      end
      
      namespace :db do
        desc "Create the database"
        task :create => :environment do
          $db.create_db
        end
        
        desc "Drop the database"
        task :drop => :environment do
          $db.drop_db
        end
        
        desc "Migrate the database with optional VERSION"
        task :migrate => :environment do
          $db.migrate(ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
        end
        
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