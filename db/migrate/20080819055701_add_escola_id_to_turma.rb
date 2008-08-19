class AddEscolaIdToTurma < ActiveRecord::Migration
  def self.up
    add_column :turmas, :escola_id, :integer
  end

  def self.down
    remove_column :turmas, :escola_id
  end
end
