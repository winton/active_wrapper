module ActiveWrapper
  class Db
    
    attr_reader :base, :env
    
    def initialize(options)
      @base = options[:base]
      @env = options[:env].to_s
    end
    
    def establish_connection
      unless ActiveRecord::Base.connected?
        config = YAML::load(File.open("#{base}/config/database.yml"))
        ActiveRecord::Base.configurations = config
        ActiveRecord::Base.establish_connection(env)
      end
    end

    def migrate(version=nil)
      ActiveRecord::Migrator.migrate("#{base}/db/migrate", version)
    end

    def migrate_reset
      if @@env == 'test'
        stdout = $stdout
        $stdout = File.new('/dev/null', 'w')
      end
      migrate(0)
      migrate
      if @@env == 'test'
        $stdout = stdout
      end
    end

    def generate_migration(name=nil)
      raise "Please specify desired migration name with NAME=my_migration_name" unless name
  
      migration_name = name.strip.chomp
      migrations_path = "#{base}/db/migrate"
      migrations_template = File.expand_path("#{File.dirname(__FILE__)}/../../resources/migration.template")
  
      # Find the highest existing migration version or set to 1
      if (existing_migrations = Dir[File.join(migrations_path, '*.rb')]).length > 0
        version = File.basename(existing_migrations.sort.reverse.first)[/^(\d+)_/,1].to_i + 1
      else
        version = 1
      end
  
      # Read the contents of the migration template into string
      migrations_template = File.read(migrations_template)
  
      # Replace the migration name in template with the acutal one
      migration_content = migrations_template.gsub('__migration_name__', migration_name.camelize)
      migration_content = migration_content.gsub('__migration_table__', migration_name)
  
      # Generate migration filename
      migration_filename = "#{"%03d" % version}_#{migration_name}.rb"
  
      # Write the migration
      File.open(File.join(migrations_path, migration_filename), "w+") do |migration|
        migration.puts migration_content
      end
  
      # Done!
      puts "Successfully created migration #{migration_filename}"
    end
  end
end