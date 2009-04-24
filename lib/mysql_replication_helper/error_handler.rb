module MysqlReplicationHelper
  module ErrorHandler
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
      when /^Error 'View '[^\']+' references invalid table\(s\) or column\(s\) or function\(s\) or definer\/invoker of view lack rights to use them' on query. Default database: '([^\']+)'. Query: 'CREATE .*? DEFINER=`([^\`]+)`@`([^\`]+)`/
        [
          "GRANT ALL PRIVILEGES ON `#{$1}`.* TO `#{$2}`@`#{$3}`",
          "START SLAVE"
        ]
      end
    end
  end
end
