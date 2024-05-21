require_relative 'criatura'

class Rata
  attr_reader :nombre

  include Criatura

  def initialize
    @nombre = 'Rata'
    @pv = 5
    @rango_de_ataque = [1, 2]
    @rango_de_exp = [1, 5]
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
    puts "¡La Rata ataca con un mordisco! Además, chilla."
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
    "#{@nombre}: #{@pv}/5 PV"
  end

  def movimiento_especifico
    "La rata se mueve velozmente."
  end

  def salud_especifica
    @pv
  end
end
