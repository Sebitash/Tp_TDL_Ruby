require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'
require_relative 'equipamiento/armas'
require_relative 'jugador'
require_relative 'juego.rb'
require_relative 'menu.rb'
require 'ruby2d'

set title: "Tiny Dungeon"
set width: 480
set height: 320

ventana = Window.new
ventana.set(title: "Tiny Dungeon", width: 480, height: 320)

jugador = Jugador.new("Jugador")
juego = Juego.new(jugador, ventana)

menu = Menu.new(ventana)

update do
  clear

  if menu.esta_abierto
    menu.abrir_menu
  else
    menu.cerrar_menu
  end

  if menu.esta_abierto == false
    juego.check_player_alive
    camera_x, camera_y = juego.move_camera
    juego.draw_mapa(camera_x, camera_y)
    juego.check_criaturas_muertas
    juego.check_criatura_attacks
  end
end

on :key_held do |event|
  if event.key == 'escape'
    menu.abrir_menu
  elsif menu.esta_abierto == false
    juego.handle_movement(event.key)
    sleep(0.05)
  else
    menu.gestionar_movimiento(event.key)
  end
  sleep(0.03)
end

show
