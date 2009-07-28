module ActiveWrapper
  class Mail
    
    attr_reader :base, :env, :config
    
    def initialize(options)
      @base = options[:base]
      @env = options[:env].to_s
      
      path = "#{base}/config/mail.yml"
      
      if @env == 'test'
        ActionMailer::Base.delivery_method = :test
      else
        @config[:smtp] = options[:smtp]
        @config[:imap] = options[:imap]
        if File.exists?(path)
          @config = YAML::load(File.open(path))
          if @config && @config = @config[@env]
            @config = @config.to_options
            @config[:imap] = @config[:imap].to_options unless @config[:imap]
            @config[:smtp] = @config[:smtp].to_options unless @config[:smtp]
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