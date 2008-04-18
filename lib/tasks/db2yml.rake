args = ARGV
args.shift

task :db2yml => :environment do
  sql  = "SELECT * FROM %s"
  skip_tables = ["schema_info", "schema_migrations"]
  ActiveRecord::Base.establish_connection
	tables = (ActiveRecord::Base.connection.tables - skip_tables)
	tables &= args unless args.empty?
  tables.each do |table_name|
    i = "000"
    File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", 'w') do |file|
      data = ActiveRecord::Base.connection.select_all(sql % table_name)
      file.write data.inject({}) { |hash, record|
        hash["#{table_name}_#{i.succ!}"] = record
        hash
      }.to_yaml
    end
  end
end
