module MysqlReplicationHelper
  class Daemon
    def initialize(options)
      @options = options
      
      @options[:master] = @master = Agent::Master.new(options)
      @options[:slave] = @slave = Agent::Slave.new(options)
    end
    
    def run!
      while (true)
        @master.poll!
        @slave.poll!
        sleep(10)
      end
    end
  end
end
