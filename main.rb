require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'
require_relative 'equipamiento/armas'
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
grifo = Grifo.new
#puts rata

combatir(jugador, rata)

nueva_arma = EspadaDeBronce.new
jugador.equipar_arma(nueva_arma)
puts jugador

combatir(jugador, rata)
combatir(jugador, rata)

combatir(jugador, grifo)

jugador.equipar_arma(EspadaDeHierro.new)
puts jugador

combatir(jugador, grifo)
combatir(jugador, grifo)
