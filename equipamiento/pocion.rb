class Pocion
  attr_reader :nombre, :recuperacion

  def initialize(nombre, recuperacion)
    @nombre = nombre
    @recuperacion = recuperacion
  end

  def to_s
    raise NotImplementedError, "#{self.class} no ha implementado el método 'to_s'"
  end

  def usar(jugador)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'usar'"
  end
end
