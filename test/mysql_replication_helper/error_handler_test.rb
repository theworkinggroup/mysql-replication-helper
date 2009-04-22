require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class MysqlReplicationHelper::ErrorHandlerTest < Test::Unit::TestCase
  def test_responses
    handler = MysqlReplicationHelper::ErrorHandler.new
    
    [
      [
        "Error 'Unknown database 'example_db'' on query. Default database: 'example_db'.",
        [ "CREATE DATABASE `example_db`", "START SLAVE" ]
      ],
      [
        "Error 'There is no 'example'@'localhost' registered' on query. Default database: 'example_db'.",
        [ "CREATE USER `example`@`localhost`", "GRANT ALL PRIVILEGES ON `example_db`.* TO `example`@`localhost`", "START SLAVE" ]
      ]
    ].each do |test_case|
      assert_equal test_case[1], handler.sql_to_recover_from(test_case[0])
    end
  end
end
