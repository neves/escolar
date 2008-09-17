class Endereco < ActiveRecord::Base
	#validates_presence_of :cep, :enderecavel_id, :enderecavel_type

  belongs_to :enderecavel, :polymorphic => true

  def vazio?
    cep.to_s.empty? && uf.to_s.empty? && cidade.to_s.empty? && bairro.to_s.empty? && logradouro.to_s.empty?
  end
end
