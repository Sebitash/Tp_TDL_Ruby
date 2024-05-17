require_relative 'criatura'

class Fenix
  attr_reader :nombre

  include Criatura

  def initialize
    @nombre = 'Rata'
    @pv = 70
    @rango_de_ataque = [10, 16]
    @rango_de_exp = [21, 42]
  end

  private

  def ataque_especifico(objetivo)
    if @pv <= 0
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

  def recibir_ataque_especifico(ataque_enemigo)
    @pv -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv <= 0
      @pv = 0
      puts "¡La rata ha muerto!"
    end
    return @pv
  end

  def exp_especifico
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  def estado_especifico
    "#{@nombre}: #{@pv}/70 PV"
  end

  def movimiento_especifico
    "El Fénix se eleva con gracia."
  end

  def salud_especifica
    @pv
  end
end
