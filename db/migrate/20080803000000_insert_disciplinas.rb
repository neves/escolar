class InsertDisciplinas < ActiveRecord::Migration
  def self.up
  	registros = []
    open("disciplinas.txt").each_line { |line| registros << line.split('|').map(&:strip) }
    # se for vazio o último índice, substitui por nil
    registros.each{|d| d[-1] = nil if d.last.empty?}
    # UNIT 36|36|1|6|0|3|
		begin
	    execute "TRUNCATE disciplinas"
		rescue
			execute "DELETE FROM disciplinas"
		end	
    Disciplina.import [:nome, :apelido, :duracao, :lotacao, :fixa, :material_id], registros
  end

  def self.down
  end
end
