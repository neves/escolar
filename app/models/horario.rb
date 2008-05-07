class Horario < ActiveRecord::Base
	has_many :disponibilidades
	has_many :professores, :through => :disponibilidades

  def self.convert(dia, hora)
    to_id dia.wday, hora
  end

  def self.to_id(dia, h = nil)
    if h.nil?
      s = dia.wday.to_i
      h = dia.hour.to_i
    else
      s = dia.to_i
    end
    s * 100 + h
  end

  def self.by_dia_hora(dia, hora)
    find(convert(dia, hora), :joins => :professores ) rescue Horario.new
  end
end
