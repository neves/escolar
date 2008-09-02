class InsertPlanos < ActiveRecord::Migration
  def self.up
  	registros = []
    open("planos.txt").each_line { |line| registros << line.split('|').map(&:strip) }
    # se for vazio o último índice, substitui por nil
    registros.each{|d| d[-1] = nil if d.last.empty?}
		begin
    	execute "TRUNCATE planos"
		rescue
		 execute "DELETE FROM planos"
		end	
    Plano.import [:curso_id, :tabela, :nome, :valor_matricula, :qtde_parcelas, :valor_parcela], registros
  end

  def self.down
	execute "TRUNCATE planos"
  end
end
