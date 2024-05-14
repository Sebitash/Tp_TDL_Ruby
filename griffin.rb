require_relative 'criatura'

class Griffin
  include Creature

  private

  def specific_attack
    "¡El Grifo ataca con fuerza! Además, araña con sus garras afiladas."
  end

  def specific_move
    "El Grifo surca los cielos con elegancia."
  end
end
