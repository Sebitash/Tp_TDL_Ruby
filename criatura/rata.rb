require_relative 'criatura'

class Rata < Criatura
  attr_reader :nombre

  def initialize
    super('Rata', [5, 5], [1, 2], [1, 5], [2, 7])
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
    puts "¡La Rata ataca con un mordisco! Además, chilla."
    objetivo.recibir_ataque(ataque)
  end

  def recibir_ataque(ataque_enemigo)
    @pv[0] -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡La Rata ha muerto!"
    end
    return @pv[0]
  end

  def movimiento
    "La rata se mueve velozmente."
  end

end
