module Creature
  def attack
    specific_attack
  end

  def move
    specific_move
  end
  def health
      specific_health
  end

  private

  def specific_attack
    raise NotImplementedError, "#{self.class} no ha implementado el método 'specific_attack'"
  end

  def specific_move
    raise NotImplementedError, "#{self.class} no ha implementado el método 'specific_move'"
  end

  def specific_health
    raise NotImplementedError, "#{self.class} no ha implementado el metodo 'specific_health"
  end
end