require_relative 'armas'

class Jugador
  attr_reader :nombre
  attr_accessor :pv, :exp

  def initialize(nombre, arma = Armas.new("Puños", [1, 2], Float::INFINITY, 0))
    @nombre = nombre
    @pv = 100  # Puntos de vida
    @pm = 100  # Puntos de mana
    @nivel = 1
    @arma = arma
    @exp = 0
  end

  def saludar
    puts "Hola, soy #{@nombre} y tengo que despejar esta mazmorra."
  end

  def estado
    if @pv <= 0
      puts "El jugador ha muerto. Fin de la partida."
    else
      puts "#{@nombre}: #{@pv}/100 PV | #{@pm}/100 PM | Nivel: #{@nivel} | EXP: #{@exp}\nArma equipada: #{@arma.estado}"
    end
  end

  def equipar_arma(arma)
    @arma = arma
    puts "¡Nueva arma equipada!"
  end

  def atacar
    @arma.atacar
  end

  def mover
    puts "#{@nombre} da un paso."
  end

end
