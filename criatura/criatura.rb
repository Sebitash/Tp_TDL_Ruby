class Criatura
  attr_reader :nombre

  def initialize(nombre, pv, rango_de_ataque, rango_de_exp, rango_de_oro)
    @nombre = nombre
    @pv = pv
    @rango_de_ataque = rango_de_ataque
    @rango_de_exp = rango_de_exp
    @rango_de_oro = rango_de_oro
  end

  def to_s
    "#{@nombre}: #{@pv[0]}/#{@pv[1]} PV | Ataque: #{@rango_de_ataque[0]}-#{@rango_de_ataque[1]}"
  end

  def pv
    @pv[0]
  end

  def exp
    rand(@rango_de_exp[0]..@rango_de_exp[1])
  end

  def oro
    rand(@rango_de_oro[0]..@rango_de_oro[1])
  end

  def atacar(objetivo)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'atacar'"
  end

  def recibir_ataque(ataque)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'recibir_ataque'"
  end

  def movimiento
    raise NotImplementedError, "#{self.class} no ha implementado el método 'movimiento'"
  end

end
