class AddNotasToAula < ActiveRecord::Migration
  def self.up
    add_column :aulas, :preparation, :integer
    add_column :aulas, :grammar, :integer
    add_column :aulas, :conversation, :integer
    add_column :aulas, :oral_ou_lab, :integer
    add_column :aulas, :total, :integer
  end

  def self.down
    remove_column :aulas, :total
    remove_column :aulas, :oral_ou_lab
    remove_column :aulas, :conversation
    remove_column :aulas, :grammar
    remove_column :aulas, :preparation
  end
end
