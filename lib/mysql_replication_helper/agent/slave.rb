module MysqlReplicationHelper
  class Agent
    class Slave < Agent
      include MysqlReplicationHelper::ErrorHandler

      def poll!
        if (configured?)
          if (error_message = slave_error)
            if (statements = sql_to_recover_from(error_message))
              statements.each do |sql|
                connection.real_query(sql)
              end
            else
              # Unrecoverable error?
            end
          end
        else
          assign_master(@options[:master])
          start!
        end
      end
      
      def configured?
        !!query("SHOW SLAVE STATUS").fetch_row
      end
      
      def slave_error
        row = query("SHOW SLAVE STATUS").fetch_row
        
        row and row[19]
      end
      
      def assign_master(master)
        master_status = master.master_status
        
        master_options =
          {
            'MASTER_HOST' => 'localhost',
            'MASTER_USER' => master.user_name,
            'MASTER_PORT' => 3306,
            'MASTER_LOG_FILE' => master_status[:master_log_file],
            'MASTER_LOG_POS' => master_status[:master_log_position]
          }.collect do |k, v|
            case (v)
            when String:
              "#{k}='#{Mysql.quote(v)}'"
            else
              "#{k}=#{v}"
            end
          end
        
        execute("CHANGE MASTER TO #{master_options * ', '}")
      end
      
      def start!
        execute("START SLAVE")
      end
      
      def user_name
        @options[:slave_user] or super
      end

      def socket_name
        @options[:slave_socket] or super
      end
    end
  end
end
