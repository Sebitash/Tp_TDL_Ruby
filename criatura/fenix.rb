require_relative 'criatura'

class Fenix < Criatura
  attr_reader :nombre

  def initialize
    super('Fénix', [70, 70], [10, 16], [21, 42], [54, 87])
  end

  def atacar(objetivo)
    if @pv[0] <= 0
      return
    end
    if objetivo.pv <= 0
      puts "El jugador ya esta muerto."
      return
    end

    ataque = rand(@rango_de_ataque[0]..@rango_de_ataque[1])
    puts "¡El Fénix ataca con fuerza! Además, golpea con sus alas ardientes."
    objetivo.recibir_ataque(ataque)
  end

  def recibir_ataque(ataque_enemigo)
    @pv[0] -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El Fénix ha muerto!"
    end
    return @pv[0]
  end

  def movimiento
    "El Fénix se eleva con gracia."
  end

end
