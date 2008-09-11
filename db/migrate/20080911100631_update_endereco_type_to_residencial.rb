class UpdateEnderecoTypeToResidencial < ActiveRecord::Migration
  def self.up
  	execute "UPDATE enderecos set `type` = 'EnderecoResidencial' WHERE `type` IS NULL"
  end

  def self.down
  	execute "UPDATE enderecos set `type` = NULL"
  end
end
