class CreatePrevisoes < ActiveRecord::Migration
  def self.up
    create_table :previsoes do |t|
      t.belongs_to :escola
      t.belongs_to :cliente, :polymorphic => true
      t.belongs_to :plano_conta
      t.string :pagar_receber, :null => false
      t.decimal :valor, :null => false, :precision => 14, :scale => 2, :default => 0
      t.decimal :valor_pago, :null => false, :precision => 14, :scale => 2, :default => 0
      t.integer :parcela, :null => false, :default => 1
      t.integer :qtde_parcelas, :null => false, :default => 1
      t.string :historico
      t.date :vencimento

      t.timestamps
    end
  end

  def self.down
    drop_table :previsoes
  end
end
