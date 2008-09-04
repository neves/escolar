class RemoverIndexesParaCpfERgDosAlunos < ActiveRecord::Migration
  def self.up
    remove_index :alunos, :rg
    remove_index :alunos, :cpf
  end

  def self.down
    add_index "alunos", ["cpf"], :name => "index_alunos_on_cpf", :unique => true
    add_index "alunos", ["rg"], :name => "index_alunos_on_rg", :unique => true
  end
end
