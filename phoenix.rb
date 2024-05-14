require_relative 'criatura'

class Phoenix
  include Creature

  private

  def specific_attack
    "¡El Fénix ataca con fuerza! Además, golpea con sus alas ardientes."
  end

  def specific_move
    "El Fénix se eleva con gracia."
  end
end
