module MysqlReplicationHelper
  class ErrorHandler
    def initialize(options = nil)
      @options = options || { }
    end
    
    def sql_to_recover_from(error)
      case (error)
      when /^Error 'Unknown database '([^\']+)'' on query/
        [
          "CREATE DATABASE `#{$1}`",
          "START SLAVE"
        ]
      when /^Error 'There is no '([^\']+)'@'([^\']+)' registered' on query. Default database: '([^\']+)'./
        [
          "CREATE USER `#{$1}`@`#{$2}`",
          "GRANT ALL PRIVILEGES ON `#{$3}`.* TO `#{$1}`@`#{$2}`",
          "START SLAVE"
        ]
      end
    end
  end
end