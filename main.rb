require_relative 'jugador'
require_relative 'juego.rb'
require_relative 'menu.rb'
require 'ruby2d'
require_relative 'util'

set title: NOMBRE_JUEGO
set width: 480
set height: 320

# Ventana del juego
ventana = Window.new
ventana.set(
  title: NOMBRE_JUEGO,
  width: 480,
  height: 320
)
system('clear') || system('cls')
print "Ingresa el nombre del jugador: "
nombre_jugador = gets.chomp
jugador = Jugador.new(nombre_jugador)

menu = Menu.new(ventana)
juego = Juego.new(
  jugador,
  ventana,
  menu
)


update_interval = 0.5 
@last_creature_update = Time.now 
update do
  clear
  if menu.esta_abierto
    menu.abrir_menu
  else
    menu.cerrar_menu
  end

  if !menu.esta_abierto
    juego.chequear_jugador_vivo
    x_camara, y_camara = juego.mover_camara
    juego.dibujar_mapa(x_camara, y_camara)
    juego.chequear_criaturas_muertas
    juego.chequear_ataque_criatura
    juego.mostrar_caracteristicas_personaje
    if Time.now - @last_creature_update >= update_interval
      juego.movimiento_criaturas
      @last_creature_update = Time.now
    end
  end
end


on :key_held do |evento|
  if evento.key == 'escape'
    menu.abrir_menu
  elsif !menu.esta_abierto
    juego.manejar_movimiento(evento.key)
    sleep(0.05)
  else
    menu.gestionar_movimiento(evento.key)
  end

  sleep(0.03)
end

at_exit do
  juego.limpiar_terminal
end
show
