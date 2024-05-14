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

  def atacar
    rand(@rango_de_ataque[0]..@rango_de_ataque[1])
  end

  def dar_exp
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  def estado
    puts "#{@nombre}: #{@pv}/5 PV"
  end

  private

  def specific_attack
    puts "¡La rata ataca con un mordisco! Además, chilla."
  end

  def specific_move
    "La rata se mueve velozmente."
  end
end
