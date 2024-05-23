module Criatura

  def atacar(objetivo)
    ataque_especifico(objetivo)
  end

  def recibir_ataque(ataque)
    recibir_ataque_especifico(ataque)
  end

  def movimiento
    movimiento_especifico
  end

  def salud
    salud_especifica
  end

  def to_s
    estado_especifico
  end

  def exp
    exp_especifico
  end

  private

  def ataque_especifico(objetivo)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'ataque_especifico'"
  end

  def recibir_ataque_especifico(ataque)
    raise NotImplementedError, "#{self.class} no ha implementado el método 'recibir_ataque_especifico'"
  end

  def movimiento_especifico
    raise NotImplementedError, "#{self.class} no ha implementado el método 'movimiento_especifico'"
  end

  def salud_especifica
    raise NotImplementedError, "#{self.class} no ha implementado el metodo 'salud_especifica"
  end

  def estado_especifico
    raise NotImplementedError, "#{self.class} no ha implementado el metodo 'estado_especifico'"
  end
end
