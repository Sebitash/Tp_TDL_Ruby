require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'
require_relative 'equipamiento/armas'
require_relative 'jugador'
require_relative 'game.rb'
require_relative 'menu.rb'

# Configuración de la ventana
set title: "Prueba Tiny Dungeon"
set width: 480
set height: 320

# Crear una instancia del jugador
player = Jugador.new("Player")

# Crear una instancia del menu
menu = Menu.new

# Crear una instancia del juego y pasarle el jugador
game = Game.new(player)

update do
  clear

  if menu.esta_abierto
    menu.abrir_menu
  else
    menu.cerrar_menu
  end

  if menu.esta_abierto == false
    game.check_player_alive
    camera_x, camera_y = game.move_camera
    game.draw_mapa(camera_x, camera_y)
    game.check_criaturas_muertas
    game.check_criatura_attacks
  end
end

on :key_held do |event|
  if event.key == 'escape'
    menu.abrir_menu
  elsif menu.esta_abierto == false
    game.handle_movement(event.key)
    sleep(0.05)
  else
    menu.gestionar_movimiento(event.key)
  end
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
