class Aluno < ActiveRecord::Base
  belongs_to :empresa
  has_many :aulas
  has_many :turmas, :through => :aulas

  def self.find_by_nome_or_subscricao(nome_or_subscricao)
    find(:first, :conditions => ["nome like :valor OR subscricao = :valor", {:valor => nome_or_subscricao}])
  end

  def nome_ou_subscricao
    nome
  end
end
