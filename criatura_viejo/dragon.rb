require_relative 'criatura'

class Dragon
  attr_reader :nombre

  include Criatura

  def initialize
    @nombre = 'Dragón'
    @pv = 300
    @rango_de_ataque = [34, 44]
    @rango_de_exp = [89, 134]
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
    puts "¡El Dragón ataca con fuerza! Además, escupe fuego."
    objetivo.recibir_ataque(ataque)
  end

  def recibir_ataque_especifico(ataque_enemigo)
    @pv -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv <= 0
      @pv = 0
      puts "¡El Dragón ha muerto!"
    end
    return @pv
  end

  def exp_especifico
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  def estado_especifico
    "#{@nombre}: #{@pv}/300 PV"
  end

  def movimiento_especifico
    "El Dragón vuela majestuosamente."
  end

  def salud_especifica
    @pv
  end

end
