class DisciplinaFixa < Disciplina
	# FIXME nao esta sendo usado, remover
	has_many :disponibilidade_fixas
	has_many :horarios, :through => :disponibilidade_fixas
	has_many :disponibilidades

  def professores_normais_por_horario
    Horario.find(:all, :include => {:professores => :habilitacoes},
         :conditions => {
            'habilitacoes.disciplina_id' => id,
            'disponibilidades.type' => 'DisponibilidadeNormal'
         }
    ).index_by(&:id)
  end

  def professores_combo_por_horario
    Horario.find(:all, 
			:include => {:professores => :habilitacoes},
      :conditions => ['(disponibilidades.type = "DisponibilidadeNormal" OR disponibilidades.disciplina_fixa_id = ?) AND habilitacoes.disciplina_id = ?', id, id]
    ).index_by(&:id)
  end


	def professores_fixos_por_horario
    Horario.find(:all, :include => {:professores => :habilitacoes},
         :conditions => {
            'habilitacoes.disciplina_id' => id, # nao traz professor sem habilitação
						'disponibilidades.disciplina_fixa_id' => id,
            'disponibilidades.type' => 'DisponibilidadeFixa'
         }
    ).index_by(&:id)
	end
end
