class RemoveColumnValorParcelasFromMatricula < ActiveRecord::Migration
  def self.up
  	remove_column :matriculas, :valor_parcelas
  end

  def self.down
  end
end
