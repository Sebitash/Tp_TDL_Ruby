require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'
require_relative 'equipamiento/arma'
require_relative 'jugador'


def combatir(jugador, criatura)
  jugador.atacar(criatura)
  criatura.atacar(jugador)

  puts jugador
  puts criatura
end

# Ejemplo de uso
jugador = Jugador.new("Fran")
#jugador.saludar
#puts jugador
#jugador.mover

rata = Rata.new
#puts rata

combatir(jugador, rata)

nueva_arma = Arma.new("Espada de bronce", [2, 5], 150, 10)
jugador.equipar_arma(nueva_arma)
puts jugador
combatir(jugador, rata)

combatir(jugador, rata)


#dragon = Dragon.new
#puts dragon.atacar       # Output: ¡El Dragón ataca con fuerza! Además, escupe fuego.
#puts dragon.movimiento   # Output: El Dragón vuela majestuosamente.

#grifo = Grifo.new
#puts grifo.atacar        # Output: ¡El Grifo ataca con fuerza! Además, araña con sus garras afiladas.
#puts grifo.movimiento    # Output: El Grifo surca los cielos con elegancia.

#fenix = Fenix.new
#puts fenix.atacar        # Output: ¡El Fénix ataca con fuerza! Además, golpea con sus alas ardientes.
#puts fenix.movimiento    # Output: El Fénix se eleva en el aire con majestuosidad.
