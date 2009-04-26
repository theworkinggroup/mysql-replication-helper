require 'rubygems'
require 'mysql'

module MysqlReplicationHelper
  # == Autoloads ============================================================
  
  autoload(:Agent, 'mysql_replication_helper/agent')
  autoload(:ErrorHandler, 'mysql_replication_helper/error_handler')
  autoload(:Daemon, 'mysql_replication_helper/daemon')
end
