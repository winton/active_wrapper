module ActiveWrapper
  class Mail
    
    attr_reader :base, :env, :config
    
    def initialize(options)
      @base = options[:base]
      @config = {
        :smtp => options[:smtp] || {},
        :sendmail => options[:sendmail] || nil,
        :imap => options[:imap] || {}
      }
      @env = options[:env].to_s
      
      path = "#{base}/config/mail.yml"
      
      if File.exists?(path)
        yaml = YAML::load(File.open(path))
        if yaml && yaml[@env]
          yaml = yaml[@env].to_options
          @config[:imap] = yaml[:imap].to_options if yaml[:imap]
          @config[:sendmail] = yaml[:sendmail] if !yaml[:sendmail].nil?
          @config[:smtp] = yaml[:smtp].to_options if yaml[:smtp]
        end
      end
      if @env == 'test'
        ActionMailer::Base.delivery_method = :test
      elsif @config[:sendmail]
        ActionMailer::Base.delivery_method = :sendmail
      elsif @config[:smtp]
        ActionMailer::Base.delivery_method = :smtp
        ActionMailer::Base.smtp_settings = @config[:smtp]
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