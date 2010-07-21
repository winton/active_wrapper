unless defined?(ActiveWrapper::Gems)
  
  require 'rubygems'
  
  module ActiveWrapper
    class Gems
    
      VERSIONS = {
        :actionmailer => '=2.3.5',
        :activerecord => '=2.3.5',
        :rake => '=0.8.7',
        :rspec => '=1.3.0'
      }
    
      TYPES = {
        :gemspec => [ :activerecord, :actionmailer, :mysql ],
        :gemspec_dev => [ :rspec ],
        :lib => [ :activerecord, :actionmailer, :mysql ],
        :rake => [ :rake, :rspec ],
        :spec => [ :rspec ]
      }
    
      def initialize(type=nil)
        (TYPES[type] || TYPES.values.flatten.compact).each do |name|
          gem name.to_s, VERSIONS[name]
        end
      end
    end
  end
end