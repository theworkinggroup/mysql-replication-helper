module MysqlReplicationHelper
  class Agent
    autoload(:Master, 'mysql_replication_helper/agent/master')
    autoload(:Slave, 'mysql_replication_helper/agent/slave')

    DEFAULT_OPTIONS = {
      :host => 'localhost',
      :user => 'root',
      :master_socket => '/local/db/mysql.sock',
      :slave_socket => '/ebs/db/mysql.sock'
    }
    
    def initialize(options)
      @options = with_default_options(options)
    end
    
    def connection
      @connection ||=
        Mysql.real_connect(
          @options[:host],
          user_name,
          @options[:password],
          @options[:db],
          @options[:port],
          socket_name
        )
    end
    
    def user_name
      @options[:user]
    end
    
    def socket_name
      @options[:socket]
    end
    
    def with_default_options(options)
      DEFAULT_OPTIONS.merge(options)
    end
    
    def execute(statement)
      STDERR.puts(statement)
      connection.real_query(statement)
    end
    
    def query(statement)
      STDERR.puts(statement)
      connection.query(statement)
    end
  end
end
