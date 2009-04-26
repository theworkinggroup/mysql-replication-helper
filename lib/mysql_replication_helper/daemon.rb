module MysqlReplicationHelper
  class Daemon
    include ErrorHandler
    
    def initialize(options)
      @options = { }
    end
    
    def start!
      # ...
      puts "Start stub"
    end
  end
end
