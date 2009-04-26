module MysqlReplicationHelper
  class Agent
    class Master < Agent
      def poll!
        # Nothing yet
      end
      
      def master_status
        row = query("SHOW MASTER STATUS").fetch_row
        
        return unless (row)
        
        {
          :master_log_file => row[0],
          :master_log_position => row[1].to_i
        }
      end
      
      def user_name
        @options[:master_user] or super
      end

      def socket_name
        @options[:master_socket] or super
      end
    end
  end
end
