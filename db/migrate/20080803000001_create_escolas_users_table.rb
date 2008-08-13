class CreateEscolasUsersTable < ActiveRecord::Migration
  def self.up
	create_table :escolas_users, :force => true do |t|
		t.references :escola, :null => false
		t.references :user, :null => false
	end
	# @TODO: create_many2many_table_between :escola, :user
  end

  def self.down
  end
end