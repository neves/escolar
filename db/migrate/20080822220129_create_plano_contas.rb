class CreatePlanoContas < ActiveRecord::Migration
  def self.up
    create_table :plano_contas, :force => true do |t|
      t.string :nome, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :plano_contas
  end
end
