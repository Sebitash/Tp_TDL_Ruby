require 'ruby2d'
require_relative 'personaje'

#set fps_cap: 30
set width: 800
set height: 600

def main
  fondo = Image.new(
    'fondo.png',
    y: -920
  )

  mensaje = Text.new(
    "Presione cualquiera tecla para comenzar",
    x: (Window.width - 350) / 2,
    y: (Window.height - 20) / 2,
    z: 1 # Para que aparezca sobre el fondo
  )

  personaje = Personaje.new

  on :key_held do |event|
    mensaje.remove

    case event.key
    when 'left'
      personaje.moverse_a_izquierda(fondo)
    when 'right'
      personaje.moverse_a_derecha(fondo)
    when 'up'
      personaje.moverse_arriba(fondo)
    when 'down'
      personaje.moverse_abajo(fondo)
    end
  end

  on :key_up do
    personaje.parar
  end

  show
end

main
