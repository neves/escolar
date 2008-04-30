class CriarTabelasIniciais < ActiveRecord::Migration
  def self.up


    create_table2 :empresas do |t|
      t.string :nome, :null => false
    end


    tabela = create_table2 :alunos do |t|
      t.belongs_to :empresa, :null => false
      t.string :nome, :null => false
      t.integer :subscricao, :null => false
    end
    add_indexes tabela, :subscricao, [:empresa_id, :subscricao]


    tabela = create_table2 :turmas do |t|
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


    tabela = create_table2 :aulas do |t|
      t.belongs_to :turma, :null => false
      t.belongs_to :aluno, :null => false
      t.string :status
    end
    add_indexes tabela, [:turma_id, :aluno_id], :status


    tabela = create_table2 :professores do |t|
      t.belongs_to :empresa
      t.string :nome
      t.string :apelido
    end
    add_indexes tabela, :empresa_id, [:apelido, :empresa_id]


    create_table2 :materiais do |t|
      t.string :nome
      t.decimal :preco, :precision => 7, :scale => 2, :null => false, :default => 0
    end


    tabela = create_table2 :disciplinas do |t|
      t.belongs_to :material
      t.string :nome, :apelido
      t.integer :duracao, :lotacao, :null => false, :default => 1
			t.boolean :fixa, :default => false
    end
		add_indexes tabela, :duracao, :lotacao, :fixa, [:apelido], [:nome]


    tabela = create_table2 :habilitacoes, :id => false do |t|
      t.belongs_to :disciplina, :professor, :null => false
    end
    add_indexes tabela, :disciplina_id, [:professor_id, :disciplina_id]


		tabela = create_table2 :disponibilidades do |t|
			t.belongs_to :professor, :horario, :disciplina
      t.boolean :ocupada, :null => false, :default => false
		end
		add_indexes tabela, :disciplina_id, :horario_id, :ocupada, [:professor_id, :horario_id]


    tabela = create_table2 :horas, :id => false do |t|
      t.integer :hora, :null => false
    end
    add_index tabela, :hora, :unique => true
    8.upto(21) do |h|
      insert_into tabela, :hora => h
    end


    tabela = create_table2 :feiras do |t|
      t.string :feira, :null => false
    end

    %w(seg ter qua qui sex sab).each_with_index do |feira, id|
      insert_into tabela, :feira => feira
    end


    tabela = create_table2 :horarios do |t|
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
		drop_tables :horas, :feiras, :horarios, :professores, :disciplinas, :habilitacoes, :disponibilidades, :empresas, :turmas, :aulas, :alunos
  end
end
