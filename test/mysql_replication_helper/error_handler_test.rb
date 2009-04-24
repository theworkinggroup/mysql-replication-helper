require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class TestHandler
  include MysqlReplicationHelper::ErrorHandler
end

class MysqlReplicationHelper::ErrorHandlerTest < Test::Unit::TestCase
  def test_responses
    handler = TestHandler.new
    
    [
      [
        "Error 'Unknown database 'example_db'' on query. Default database: 'example_db'.",
        [ "CREATE DATABASE `example_db`", "START SLAVE" ]
      ],
      [
        "Error 'There is no 'example_user'@'example_host' registered' on query. Default database: 'example_db'.",
        [ "CREATE USER `example_user`@`example_host`", "GRANT ALL PRIVILEGES ON `example_db`.* TO `example_user`@`example_host`", "START SLAVE" ]
      ],
      [
        "Error 'View 'example_db.example_table' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them' on query. Default database: 'example_db'. Query: 'CREATE ALGORITHM=UNDEFINED DEFINER=`example_user`@`example_host` SQL SECURITY DEFINER VIEW",
        [ "GRANT ALL PRIVILEGES ON `example_db`.* TO `example_user`@`example_host`", "START SLAVE" ]
      ]
    ].each do |test_case|
      assert_equal test_case[1], handler.sql_to_recover_from(test_case[0])
    end
  end
end
