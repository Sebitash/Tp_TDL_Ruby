require_relative 'dragon'
require_relative 'griffin'
require_relative 'phoenix'

# Ejemplo de uso
dragon = Dragon.new
puts dragon.attack     # Output: ¡El Dragón ataca con fuerza! Además, escupe fuego.
puts dragon.move       # Output: El Dragón vuela majestuosamente.

griffin = Griffin.new
puts griffin.attack    # Output: ¡El Grifo ataca con fuerza! Además, araña con sus garras afiladas.
puts griffin.move      # Output: El Grifo surca los cielos con elegancia.

phoenix = Phoenix.new
puts phoenix.attack    # Output: ¡El Fénix ataca con fuerza! Además, golpea con sus alas ardientes.
puts phoenix.move  