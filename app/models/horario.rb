class Horario < ActiveRecord::Base
	has_many :disponibilidades
	has_many :professores, :through => :disponibilidades

  def self.convert(dia, hora)
    dia.wday * 100 + hora
  end

  def self.by_dia_hora(dia, hora)
    find(convert(dia, hora), :joins => :professores ) rescue Horario.new
  end
end
