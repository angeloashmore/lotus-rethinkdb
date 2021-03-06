$VERBOSE=nil # to avoid plenty of warnings
require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
$LOAD_PATH.unshift 'lib'
require 'hanami-rethinkdb'

require 'coveralls'
Coveralls.wear!

include RethinkDB::Shortcuts

RETHINKDB_TEST_URI = 'rethinkdb://localhost:28015/test'

conn = r.connect

[:test_users, :test_users_datetime, :test_devices].each do |t_name|
  begin
    r.table(t_name).delete
    r.table_create(t_name).run(conn)
  rescue RethinkDB::RqlRuntimeError => _e
    puts "Table `#{t_name}` already exists"
  end
end
