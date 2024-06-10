require_relative 'criatura'

class Dragon < Criatura
  attr_reader :nombre

  def initialize
    super(
      'Dragon',
      [300, 300],
      [34, 44],
      [89, 134],
      [213, 341]
    )
  end

  def atacar(objetivo)
    # if @pv[0] <= 0
    #   return
    # end

    # if objetivo.pv <= 0
    #   puts "El jugador ya esta muerto."
    #   return
    # end

    # daño = rand(@rango_de_daño[0]..@rango_de_daño[1])
    # puts "¡El Dragón ataca con fuerza! Además, escupe fuego."
    # objetivo.recibir_ataque(daño)
  end

  def recibir_ataque(puntos_de_daño)
    @pv[0] -= puntos_de_daño

    puts "#{@nombre} recibe #{puntos_de_daño} puntos de daño."

    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El Dragón ha muerto!"
    end

    return @pv[0]
  end

  def movimiento(mapa, criaturas, x_jugador, y_jugador)
    # Calcula las direcciones en las que puede moverse el Dragón
    movimientos_posibles = [
      [1, 0], [-1, 0], [0, 1], [0, -1]
    ]
  
    # Encuentra la dirección hacia el jugador
    direccion_x = (x_jugador - @x).clamp(-1, 1)
    direccion_y = (y_jugador - @y).clamp(-1, 1)
  
    # Intenta moverse en la dirección hacia el jugador si es posible
    if puede_moverse_a?(@x + direccion_x, @y + direccion_y, mapa, criaturas, x_jugador, y_jugador)
      @x = @x + direccion_x
      @y = @y + direccion_y
      return "El Dragón sigue al jugador."
    end
  
    # Si no puede moverse hacia el jugador, intenta moverse en otras direcciones posibles
    movimientos_posibles.shuffle.each do |movimiento|
      nueva_x = @x + movimiento[0]
      nueva_y = @y + movimiento[1]
      if puede_moverse_a?(nueva_x, nueva_y, mapa, criaturas, x_jugador, y_jugador)
        @x = nueva_x
        @y = nueva_y
        return "El Dragón sigue al jugador."
      end
    end
  
    # Si no puede moverse en ninguna dirección, se queda en su posición actual
    return "El Dragón no puede moverse hacia el jugador."
  end

end
