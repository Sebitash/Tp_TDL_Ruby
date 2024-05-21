require_relative 'criatura'

class Dragon < Criatura
  attr_reader :nombre

  def initialize
    super('Dragón', [300, 300], [34, 44], [89, 134], [213, 341])
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
    puts "¡El Dragón ataca con fuerza! Además, escupe fuego."
    objetivo.recibir_ataque(ataque)
  end

  def recibir_ataque(ataque_enemigo)
    @pv[0] -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El Dragón ha muerto!"
    end
    return @pv[0]
  end

  def movimiento
    "El Dragón vuela majestuosamente."
  end

end
