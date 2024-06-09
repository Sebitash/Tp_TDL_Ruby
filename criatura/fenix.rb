require_relative 'criatura'

class Fenix < Criatura
  attr_reader :nombre

  def initialize
    super(
      'Fenix',
      [70, 70],
      [10, 16],
      [21, 42],
      [54, 87]
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
    # puts "¡El Fénix ataca con fuerza! Además, golpea con sus alas ardientes."
    # objetivo.recibir_ataque(daño)
  end

  def recibir_ataque(puntos_de_daño)
    @pv[0] -= puntos_de_daño
    puts "#{@nombre} recibe #{puntos_de_daño} puntos de daño."

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
