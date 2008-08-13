class CriarTabelasIniciais < ActiveRecord::Migration
  def self.up

    create_table2 :escolas, :force => true do |t|
      t.string :nome, :null => false
	  t.string :fuso, :null => false, :default => "-3"
	  t.decimal :preco_kit, :null => false, :precision => 14, :scale => 2
    end

	registros = []
    open("escolas.txt").each_line { |line| registros << line.split('|').map(&:strip) }
    Escola.import [:nome, :fuso, :preco_kit], registros

    create_table :alunos, :force => true do |t|
      t.references :escola, :null => false
      t.references :profissao

      t.string :nome, :null => false
      t.integer :subscricao, :null => false
      t.string :email, :null => false

      t.string :cpf
      t.string :rg
      t.date :data_nasc
      t.string :sexo, :null => false, :default => "M"

      t.string :responsavel_nome
      t.date :responsavel_data_nasc
      t.string :responsavel_cpf
      t.string :responsavel_rg

      t.string :telefone_residencial
      t.string :telefone_celular
      t.string :telefone_comercial

      t.timestamps
    end

    add_index :alunos, :subscricao
	add_index :alunos, :email, :unique => true
	add_index :alunos, :cpf, :unique => true
	add_index :alunos, :rg, :unique => true
    add_index :alunos, [:escola_id, :subscricao], :unique => true

    Aluno.create!(:nome => "Teste", :subscricao => 0, :email => "marcos.neves@gmail.com", :escola_id => 1, :sexo => "M")

    create_table :enderecos, :force => true do |t|
      t.belongs_to :enderecavel, :polymorphic => true
      t.integer :cep, :null => false
      t.string :nome
      t.string :uf, :null => false
      t.string :cidade, :null => false
      t.string :bairro
      t.string :tipo_logradouro, :null => false
      t.string :logradouro, :null => false
      t.integer :numero
      t.string :complemento

      t.timestamp
    end

    tabela = create_table2 :turmas, :force => true do |t|
      t.belongs_to :professor, :null => false
      t.belongs_to :disciplina, :null => false
      t.datetime :quando, :null => false
      t.date :data, :null => false
      t.time :time, :null => false
      t.integer :hora, :null => false
      t.integer :semana, :null => false
      t.belongs_to :horario, :null => false
    end
    add_indexes tabela, [:professor_id, :quando], :disciplina_id


    tabela = create_table2 :aulas, :force => true do |t|
      t.belongs_to :turma, :null => false
      t.belongs_to :aluno, :null => false
      t.string :status
    end
    add_indexes tabela, [:turma_id, :aluno_id], :status


    tabela = create_table2 :professores, :force => true do |t|
      t.belongs_to :escola
      t.string :nome
      t.string :apelido
    end
    add_indexes tabela, :escola_id, [:apelido, :escola_id]


    tabela = create_table2 :materiais, :force => true do |t|
      t.string :nome
    end

    add_index tabela, :nome, :unique => true

    %w(Kit.I Kit.II Kit.III).each {|nome| Material.create(:nome => nome)}

    tabela = create_table2 :disciplinas, :force => true do |t|
      t.belongs_to :material
      t.string :nome, :apelido
      t.integer :duracao, :lotacao, :null => false, :default => 1
			t.boolean :fixa, :default => false
    end
		add_indexes tabela, :duracao, :lotacao, :fixa, [:apelido], [:nome]


    tabela = create_table2 :habilitacoes, :id => false, :force => true do |t|
      t.belongs_to :disciplina, :professor, :null => false
    end
    add_indexes tabela, :disciplina_id, [:professor_id, :disciplina_id]


		tabela = create_table2 :disponibilidades, :force => true do |t|
			t.belongs_to :professor, :horario, :disciplina
      t.boolean :ocupada, :null => false, :default => false
		end
		add_indexes tabela, :disciplina_id, :horario_id, :ocupada, [:professor_id, :horario_id]


    tabela = create_table2 :horas, :id => false, :force => true do |t|
      t.integer :hora, :null => false
    end
    add_index tabela, :hora, :unique => true
    8.upto(21) do |h|
      insert_into tabela, :hora => h
    end


    tabela = create_table2 :feiras, :force => true do |t|
      t.string :feira, :null => false
    end

    %w(seg ter qua qui sex sab).each_with_index do |feira, id|
      insert_into tabela, :feira => feira
    end


    tabela = create_table2 :horarios, :force => true do |t|
      t.integer :hora, :semana
    end
    add_indexes tabela, :hora, [:semana, :hora]

    1.upto(6) do |semana|
      8.upto(21) do |hora|
        break if semana == 6 && hora > 17
        id = semana * 100 + hora
        insert_into :horarios, :id => id, :semana => semana, :hora => hora
      end
    end
	end

  def self.down
		drop_tables :horas, :feiras, :horarios, :professores, :disciplinas, :habilitacoes, :disponibilidades, :escolas, :turmas, :aulas, :alunos, :enderecos
  end
end
