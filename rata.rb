require_relative 'criatura'

class Rata
  attr_reader :nombre
  attr_accessor :pv

  include Creature

  def initialize
    @nombre = 'Rata'
    @pv = 5
    @rango_de_ataque = [1, 2]
    @rango_de_exp = [1, 5]
  end

  private
  def ataque_especifico
    rand(@rango_de_ataque[0]..@rango_de_ataque[1])
  end

  def exp_especifico
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  def estado_especifico
    puts "#{@nombre}: #{@pv}/5 PV"
  end
  def movimiento_especifico
    "La rata se mueve velozmente."
  end
  def salud_especifica
    @PV
  end
end
