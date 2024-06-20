require_relative 'criatura'

class Fantasma < Criatura
  attr_reader :nombre

  def initialize
    super(
      'Fantasma',
      [120, 120],
      [15, 21],
      [43, 67],
      [30, 61]
    )
  end

  def atacar(objetivo)
    if @pv[0] <= 0
      return
    end

    if objetivo.pv <= 0
      puts "El jugador ya esta muerto."
      return
    end

    daño = rand(@rango_de_daño[0]..@rango_de_daño[1])
    puts "¡El Fantasma ataca con fuerza! Además, emite  alaridos  ensordecedores."
    objetivo.recibir_ataque(daño)
  end

  def recibir_ataque(puntos_de_daño)
    @pv[0] -= puntos_de_daño
    puts "#{@nombre} recibe #{puntos_de_daño} puntos de daño."

    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El Fantasma ha muerto!"
    end

    return @pv[0]
  end

  def movimiento(mapa, criaturas, x_jugador, y_jugador)
    loop do
      nuevo_x = rand(mapa[0].size)
      nuevo_y = rand(mapa.size)

      if puede_moverse_a?(nuevo_x, nuevo_y, mapa, criaturas, x_jugador, y_jugador)
        @x = nuevo_x
        @y = nuevo_y
        break
      end
    end
  end

end
