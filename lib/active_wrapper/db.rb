module ActiveWrapper
  class Db
    
    attr_reader :base, :config, :env
    
    def initialize(options)
      @base = options[:base]
      if File.exists?(path = "#{base}/config/database.yml")
        @config = YAML::load(File.open(path))
      end
      @env = options[:env].to_s
    end
    
    def connected?
      ActiveRecord::Base.connected?
    end
    
    def create_db
      establish_connection('database' => nil)
      ActiveRecord::Base.connection.create_database config[env]['database']
      establish_connection({})
    end
    
    def drop_db
      establish_connection('database' => nil)
      ActiveRecord::Base.connection.drop_database config[env]['database']
    end
    
    def establish_connection(options=nil)
      if !connected? || options
        config_clone = Marshal.load(Marshal.dump(config))
        config_clone[env].merge!(options || {})
        ActiveRecord::Base.configurations = config_clone
        ActiveRecord::Base.establish_connection(env)
      end
    end

    def migrate(version=nil)
      redirect_stdout do
        ActiveRecord::Migrator.migrate("#{base}/db/migrate", version)
      end
    end

    def migrate_reset
      redirect_stdout do
        migrate(0)
        migrate
      end
    end

    def generate_migration(name=nil)
      redirect_stdout do
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
    
    def method_missing(method, *args)
      ActiveRecord::Base.connection.send(method, *args)
    end
    
    def redirect_stdout(&block)
      if env == 'test'
        stdout = $stdout
        $stdout = File.new('/dev/null', 'w')
      end
      yield
      if env == 'test'
        $stdout = stdout
      end
    end
  end
end