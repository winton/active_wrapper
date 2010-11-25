module ActiveWrapper
  class Email
    
    attr_reader :base, :env, :config
    
    def initialize(options)
      @base = options[:base]
      @config = {
        :smtp => options[:smtp],
        :sendmail => options[:sendmail]
      }
      @env = options[:env].to_s
      
      path = "#{base}/config/mail.yml"
      via = nil
      
      if File.exists?(path)
        yaml = YAML::load(File.open(path))
        if yaml && yaml[@env]
          yaml = yaml[@env].to_options
          [ :sendmail, :smtp ].each do |type|
            if yaml[type]
              via = type
              if yaml[type].respond_to?(:to_options)
                @config[type] = yaml[type].to_options
              end
            end
          end
        end
      end
      
      if via
        ::Pony.options = { :via => via, :via_options => config[via] }
      end
    end
    
    def deliver(options)
      ::Pony.mail options
    end
  end
end