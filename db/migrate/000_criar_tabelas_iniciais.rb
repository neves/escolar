class CriarTabelasIniciais < ActiveRecord::Migration
  def self.up
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
        id = semana * 100 + hora
        insert_into :horarios, :id => id, :semana => semana, :hora => hora
      end
    end


    create_table :professores do |t|
      t.string :nome, :null => false
    end


    tabela = create_table2 :disciplinas do |t|
			t.inheritable :default => 'DisciplinaNormal'
      t.string :nome, :apelido, :null => false
      t.belongs_to :curso, :material
      t.integer :duracao, :lotacao, :null => false, :default => 1
    end
    add_indexes tabela, :type, :curso_id, :material_id, :duracao, :lotacao


    tabela = create_table2 :habilitacoes do |t|
      t.belongs_to :disciplina, :professor
    end
    add_indexes tabela, :disciplina_id, [:professor_id, :disciplina_id]


		tabela = create_table2 :disponibilidades do |t|
			t.inheritable :default => 'DisponibilidadeNormal'
			t.belongs_to :professor, :horario, :disciplina

		end
		add_indexes tabela, :type, :disciplina_id, :horario_id, [:professor_id, :horario_id]

	end

  def self.down
		drop_tables :horas, :feiras, :horarios, :professores, :disciplinas, :habilitacoes, :disponibilidades
  end
end
