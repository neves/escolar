class Hora < ActiveRecord::Base
	set_primary_key 'hora'

  def self.para_disciplina(disc)
    find(:all, :conditions => ['hora <= 22 - ?', disc.duracao])
  end

	def to_s
		hora.to_s
	end

	def +(value)
		hora + value
	end
end
