require_relative '../juego.rb'
class Criatura
  attr_reader :nombre
  attr_accessor :x, :y

  def initialize(nombre, pv, rango_de_daño, rango_de_exp, rango_de_oro)
    @nombre = nombre
    @pv = pv # Puntos de vida
    @rango_de_daño = rango_de_daño
    @rango_de_exp = rango_de_exp
    @rango_de_oro = rango_de_oro
    @x = 0
    @y = 0
  end

  # Muestra la información del nombre, rango de vida y de daño de una criatura
  def to_s
    "#{@nombre}:
    #{@pv[0]}/#{@pv[1]} PV |
    Rango de daño: #{@rango_de_daño[0]}-#{@rango_de_daño[1]}"
  end

  # Puntos de vida actuales de una criatura
  def pv
    @pv[0]
  end

  # Experiencia que puede soltar una criatura
  def exp
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  # Oro que puede soltar una criatura
  def oro
    rand(@rango_de_oro[0]..@rango_de_oro[1])
  end

  def atacar(objetivo)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'atacar'"
  end

  # Retorna los puntos de vida que le quedan a la criatura después del ataque
  def recibir_ataque(ataque)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'recibir_ataque'"
  end

  def movimiento
    raise NotImplementedError, "#{self.class} no ha implementado el método 'movimiento'"
  end

  private

  def puede_moverse_a?(x, y, mapa, criaturas, x_jugador, y_jugador)
    return false if x < 0 || y < 0 || x >= mapa[0].size || y >= mapa.size
    return false unless OBJETOS_ATRAVESABLES.include?(mapa[y][x])
    return false if mapa[y][x] == '1' # Asumiendo que '1' representa una pared
    return false if criaturas.any? { |criatura| criatura.x == x && criatura.y == y }
    return false if x_jugador == x && y_jugador == y
    true
  end

end
