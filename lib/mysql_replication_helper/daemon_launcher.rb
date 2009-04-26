#!/usr/bin/env ruby
#
# Daemonize module
#

require 'rubygems'
require 'yaml'
require 'optparse'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'mysql_replication_helper'

# == Constants ==============================================================

CONFIG_FILE_LOCATIONS = [
  "/etc/replication-helper.conf",
  "/etc/replication-helper/config",
  "~/.replication-helper/config"
].collect { |p| File.expand_path(p) }.freeze

DEFAULT_CONFIG = {
}

# == Options ================================================================

op = OptionParser.new
options = { }
config = { }
config_file = nil

op.on("--master-socket=s") { |socket| options[:master_socket] = socket }
op.on("--master-data=s") { |dir| options[:master_data] = dir }
op.on("--master-user=s") { |name| options[:master_user] = name }

op.on("--slave-socket=s") { |socket| options[:slave_socket] = socket }
op.on("--slave-data=s") { |dir| options[:slave_data] = dir }
op.on("--slave-user=s") { |name| options[:slave_user] = name }

op.on("-c", "--config=s") { |path| config_file = path }
op.on("-v", "--verbose") { options[:verbose] = true }
op.on("-d", "--daemon") { options[:daemon] = true }
op.on("-h", "--help") { show_help }

args = op.parse(*ARGV)

# == Configuration ==========================================================

if (config_file)
  if (File.exist?(config_file))
    config = YAML.load(open(config_file))
  end
end

config = DEFAULT_CONFIG.merge(config).merge(options)

# == Main ===================================================================

MysqlReplicationHelper::Daemon.new(config).run!
