unless defined?(ActiveWrapper::Gems)
  
  require 'rubygems'
  
  module ActiveWrapper
    class Gems
    
      VERSIONS = {
        :activerecord => '=3.0.3',
        :mysql2 => '=0.2.6',
        :rake => '=0.8.7',
        :rspec => '=1.3.1'
      }
    
      TYPES = {
        :gemspec => [ :activerecord, :mysql2 ],
        :gemspec_dev => [ :rspec ],
        :lib => [ :activerecord, :mysql2 ],
        :rake => [ :rake, :rspec ],
        :spec => [ :rspec ]
      }
      
      class <<self
        
        def lockfile
          file = File.expand_path('../../../gems', __FILE__)
          unless File.exists?(file)
            File.open(file, 'w') do |f|
              Gem.loaded_specs.each do |key, value|
                f.puts "#{key} #{value.version.version}"
              end
            end
          end
        end
        
        def require(type=nil)
          (TYPES[type] || TYPES.values.flatten.compact).each do |name|
            gem name.to_s, VERSIONS[name]
          end
        end
      end
    end
  end
end