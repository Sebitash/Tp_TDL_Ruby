require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'

class CreadorCriaturas

  def self.crear(tipo)
    case tipo
      when 'Rata'
        Rata.new
      when 'Goblin'
        Dragon.new
      when 'Fenix'
        Fenix.new
      when 'Grifo'
        Grifo.new
      else
        raise "Tipo de criatura desconocido: #{tipo}"
      end
    end
  end
