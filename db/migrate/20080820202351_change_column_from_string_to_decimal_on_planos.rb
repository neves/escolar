class ChangeColumnFromStringToDecimalOnPlanos < ActiveRecord::Migration
  def self.up
  	change_column :planos, :valor_matricula, :decimal, :null => false, :default => 0, :precision => 14, :scale => 2
  	change_column :planos, :valor_parcela, :decimal, :null => false, :default => 0, :precision => 14, :scale => 2
  	change_column :planos, :qtde_parcelas, :integer, :null => false, :default => 0
  end

  def self.down
  	change_column :planos, :valor_matricula, :string, :null => false, :precision => 14, :scale => 2
  	change_column :planos, :valor_parcela, :string, :null => false, :precision => 14, :scale => 2
  	change_column :planos, :qtde_parcelas, :string, :null => false, :default => 0
  end
end
