module ActiveWrapper
  class Log
    
    attr_reader :base, :log, :logger, :stdout
    
    def initialize(options)
      @base = options[:base]
      @log = options[:log]
      @stdout = options[:stdout]
      
      return if @log == false
      
      FileUtils.mkdir_p("#{base}/log")
      file = File.open("#{base}/log/#{log}", 'a')
      file.sync = true
      
      if stdout
        @logger = Logger.new($stdout)
        $stdout.reopen(file)
        $stderr.reopen(file)
      else
        @logger = Logger.new(file)
      end
      
      ActiveRecord::Base.logger = @logger
    end
    
    def clear
      Dir["#{base}/log/*.log"].each do |file|
        f = File.open(file, "w")
        f.close
      end
    end
    
    def method_missing(method, *args)
      logger.send(method, *args)
    end
  end
end