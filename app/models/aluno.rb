class Aluno < ActiveRecord::Base
  belongs_to :escola
  belongs_to :profissao
  has_many :aulas
  has_many :turmas, :through => :aulas
  has_one :endereco_residencial, :as => :enderecavel, :class_name => 'Endereco'
  has_one :endereco_comercial, :as => :enderecavel, :class_name => 'Endereco'
  validates_uniqueness_of :subscricao, :scope => :escola_id
  validates_uniqueness_of :email, :cpf, :rg
  validates_presence_of :escola, :nome, :subscricao, :email, :sexo
  validates_inclusion_of :sexo, :in => %w( M F )

  def self.find_by_nome_or_subscricao(nome_or_subscricao)
    find(:first, :conditions => ["nome like :valor OR subscricao = :valor", {:valor => nome_or_subscricao}])
  end

  def nome_ou_subscricao
    nome
  end
end
