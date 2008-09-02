require 'hot_migrations'

ActiveRecord::ConnectionAdapters::TableDefinition.send :include, HotMigrations::Table
ActiveRecord::ConnectionAdapters::AbstractAdapter.send :include, HotMigrations::Schema
