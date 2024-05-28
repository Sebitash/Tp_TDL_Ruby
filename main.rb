require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'
require_relative 'equipamiento/armas'
require_relative 'jugador'
require_relative 'game.rb'

# Configuración de la ventana
set title: "Prueba Tiny Dungeon"
set width: 480
set height: 320

# Crear una instancia del jugador
player = Jugador.new("Player")

# Crear una instancia del juego y pasarle el jugador
game = Game.new(player)
update do
  
  
  clear
  game.check_player_alive
  camera_x, camera_y = game.move_camera
  game.draw_mapa(camera_x, camera_y)
  game.check_criaturas_muertas
  game.check_criatura_attacks
end

on :key_held do |event|
  game.handle_movement(event.key)
  sleep(0.03)
end

show

# def combatir(jugador, criatura)
#   jugador.atacar(criatura)
#   criatura.atacar(jugador)

#   puts jugador
#   puts criatura
# end

# # Ejemplo de uso
# jugador = Jugador.new("Fran")
# #jugador.saludar
# #puts jugador
# #jugador.mover

# rata = Rata.new
# grifo = Grifo.new
# #puts rata

# combatir(jugador, rata)

# nueva_arma = EspadaDeBronce.new
# jugador.equipar_arma(nueva_arma)
# puts jugador

# combatir(jugador, rata)
# combatir(jugador, rata)

# combatir(jugador, grifo)

# jugador.equipar_arma(EspadaDeHierro.new)
# puts jugador

# combatir(jugador, grifo)
# combatir(jugador, grifo)


