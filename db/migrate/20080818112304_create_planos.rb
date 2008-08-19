class CreatePlanos < ActiveRecord::Migration
  def self.up
    create_table :planos, :force => true do |t|
      t.belongs_to :curso, :null => false, :default => 1
      t.string :tabela
      t.string :nome, :null => false
      t.string :valor_matricula, :null => false, :precision => 14, :scale => 2
      t.string :qtde_parcelas
      t.string :valor_parcela, :null => false, :precision => 14, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :planos
  end
end
