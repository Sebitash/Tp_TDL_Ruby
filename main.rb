require_relative 'criatura/dragon'
require_relative 'criatura/grifo'
require_relative 'criatura/fenix'
require_relative 'criatura/rata'
require_relative 'equipamiento/armas'
require_relative 'jugador'
require_relative 'game.rb'
require_relative 'menu.rb'

set title: "Prueba Tiny Dungeon"
set width: 480
set height: 320

ventana = Window.new
ventana.set(title: "Tiny Dungeon", width: 480, height: 320)

player = Jugador.new("Player")

game = Game.new(player, ventana)

menu = Menu.new(ventana)


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
    sleep(0.02)
  else
    menu.gestionar_movimiento(event.key)
    sleep(0.03)
  end
end

show

