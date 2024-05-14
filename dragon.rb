require_relative 'criatura'

class Dragon
  include Creature

  private

  def specific_attack
    "¡El Dragón ataca con fuerza! Además, escupe fuego."
  end

  def specific_move
    "El Dragón vuela majestuosamente."
  end
end
