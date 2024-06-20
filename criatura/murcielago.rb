require_relative 'criatura'

class Murcielago < Criatura
  attr_reader :nombre

  def initialize
    super(
      'Murcielago',
      [70, 70],
      [10, 16],
      [21, 42],
      [54, 87]
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
    puts "¡El Murcielago ataca con fuerza! Además, golpea con sus alas filosas."
    objetivo.recibir_ataque(daño)
  end

  def recibir_ataque(puntos_de_daño)
    @pv[0] -= puntos_de_daño
    puts "#{@nombre} recibe #{puntos_de_daño} puntos de daño."

    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El Murcielago ha muerto!"
    end

    return @pv[0]
  end

  def movimiento(mapa, criaturas, x_jugador, y_jugador)
    movimientos_posibles = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],         [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]
    ]

    movimiento = movimientos_posibles.sample
    nueva_x = @x + movimiento[0]
    nueva_y = @y + movimiento[1]

    if puede_moverse_a?(nueva_x, nueva_y, mapa, criaturas, x_jugador, y_jugador)
      @x = nueva_x
      @y = nueva_y
    end
  end

end
