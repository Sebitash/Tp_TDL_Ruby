require_relative 'criatura/ciclope'
require_relative 'criatura/fantasma'
require_relative 'criatura/murcielago'
require_relative 'criatura/rata'

class CreadorCriaturas

  def self.crear(tipo)
    case tipo
      when 'Rata'
        Rata.new
      when 'Murcielago'
        Murcielago.new
      when 'Fantasma'
        Fantasma.new
      when 'Ciclope'
        Ciclope.new
      else
        raise "Tipo de criatura desconocido: #{tipo}"
      end
    end
  end
