class Aluno < ActiveRecord::Base
  belongs_to :empresa

  def self.find_by_nome_or_subscricao(nome_or_subscricao)
    find(:first, :conditions => ["nome like :valor OR subscricao = :valor", {:valor => nome_or_subscricao}])
  end
end
