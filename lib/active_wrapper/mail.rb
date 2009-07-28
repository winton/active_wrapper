module ActiveWrapper
  class Mail
    
    attr_reader :base, :env, :config
    
    def initialize(options)
      @base = options[:base]
      @config = {}
      @env = options[:env].to_s
      
      path = "#{base}/config/mail.yml"
      
      if @env == 'test'
        ActionMailer::Base.delivery_method = :test
      else
        @config[:smtp] = options[:smtp]
        @config[:imap] = options[:imap]
        if File.exists?(path)
          yaml = YAML::load(File.open(path))
          if yaml && yaml = yaml[@env].to_options
            @config[:imap] = yaml[:imap].to_options unless @config[:imap]
            @config[:smtp] = yaml[:smtp].to_options unless @config[:smtp]
          end
        end
        if @config[:smtp]
          ActionMailer::Base.delivery_method = :smtp
          ActionMailer::Base.smtp_settings = @config[:smtp]
        end
      end
    end
    
    def deliver(options)
      Mailer.deliver_email(options)
    end
    
    class Mailer < ActionMailer::Base
      def email(options)
        from        options[:from]
        recipients  options[:to]
        subject     options[:subject]
        body        options[:body]
      end
    end
  end
end