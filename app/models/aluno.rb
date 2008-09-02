class Aluno < ActiveRecord::Base
  belongs_to :escola
  belongs_to :profissao
  has_many :aulas
  has_many :matriculas
  has_many :previsoes, :as => :cliente
  has_many :turmas, :through => :aulas
  has_one :endereco_residencial, :as => :enderecavel, :class_name => 'Endereco'
  has_one :endereco_comercial, :as => :enderecavel, :class_name => 'Endereco'
  validates_uniqueness_of :subscricao, :email, :cpf, :rg, :scope => :escola_id
  validates_presence_of :escola, :nome, :subscricao, :email, :sexo
  validates_inclusion_of :sexo, :in => %w( M F )

  def initialize(*args)
  	super(*args)
  	self.subscricao = Aluno::proxima_subscricao
  end

  def self.find_by_nome_or_subscricao(nome_or_subscricao)
    find(:first, :conditions => ["nome like :valor OR subscricao = :valor", {:valor => nome_or_subscricao}])
  end

  def nome_ou_subscricao
    nome
  end

  def self.proxima_subscricao
  	Integer(maximum(:subscricao)) + 1
  end
end
