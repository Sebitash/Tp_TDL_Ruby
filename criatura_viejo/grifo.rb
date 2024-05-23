require_relative 'criatura'

class Grifo
  attr_reader :nombre

  include Criatura

  def initialize
    @nombre = 'Grifo'
    @pv = 120
    @rango_de_ataque = [15, 21]
    @rango_de_exp = [43, 67]
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
    puts "¡El Grifo ataca con fuerza! Además, araña con sus garras afiladas."
    objetivo.recibir_ataque(ataque)
  end

  def recibir_ataque_especifico(ataque_enemigo)
    @pv -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv <= 0
      @pv = 0
      puts "¡El Grifo ha muerto!"
    end
    return @pv
  end

  def exp_especifico
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  def estado_especifico
    "#{@nombre}: #{@pv}/120 PV"
  end

  def movimiento_especifico
    "El Grifo surca los cielos con elegancia."
  end

  def salud_especifica
    @pv
  end
end
