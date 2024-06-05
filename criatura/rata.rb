require_relative 'criatura'

class Rata < Criatura
  attr_reader :nombre

  def initialize
    super(
      'Rata',
      [5, 5],
      [1, 2],
      [1, 5],
      [2, 7]
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
    puts "¡La Rata ataca con un mordisco! Además, chilla."
    objetivo.recibir_ataque(daño)
  end

  def recibir_ataque(puntos_de_daño)
    @pv[0] -= puntos_de_daño
    puts "#{@nombre} recibe #{puntos_de_daño} puntos de daño."

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
