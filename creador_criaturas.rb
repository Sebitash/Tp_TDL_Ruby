require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'

class CreadorCriaturas

  def self.crear(tipo)
    case tipo
      when 'Rata'
        Rata.new
      when 'Dragon'
        Dragon.new
      when 'Fenix'
        Fenix.new
      when 'Grifo'
        Grifo.new
      end
    end
  end
