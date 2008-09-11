class AdicionarColunaTypeNaTabelaEnderecos < ActiveRecord::Migration
  def self.up
    add_column :enderecos, :type, :string, :length => 50
  end

  def self.down
    remove_column(:enderecos, :type)
  end
end
