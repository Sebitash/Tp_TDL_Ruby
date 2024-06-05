require_relative 'jugador'
require_relative 'juego.rb'
require_relative 'menu.rb'
require 'ruby2d'

set title: "Tiny Dungeon"
set width: 480
set height: 320

# Ventana del juego
ventana = Window.new
ventana.set(
  title: "Tiny Dungeon",
  width: 480,
  height: 320
)

jugador = Jugador.new("Jugador")

juego = Juego.new(
  jugador,
  ventana
)

menu = Menu.new(ventana)

update do
  clear

  if menu.esta_abierto
    menu.abrir_menu
  else
    menu.cerrar_menu
  end

  if !menu.esta_abierto
    juego.check_player_alive
    camera_x, camera_y = juego.move_camera
    juego.draw_mapa(camera_x, camera_y)
    juego.check_criaturas_muertas
    juego.check_criatura_attacks
  end
end

on :key_held do |evento|
  if evento.key == 'escape'
    menu.abrir_menu
  elsif !menu.esta_abierto
    juego.handle_movement(evento.key)
    sleep(0.05)
  else
    menu.gestionar_movimiento(evento.key)
  end

  sleep(0.03)
end

show
