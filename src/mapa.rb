require 'ruby2d'

#set fps_cap: 30
set width: 800
set height: 600

PASO = 15

IMAGEN_ANCHO = 3072
IMAGEN_ALTO = 1536

SPRITE_ANCHO = 256
SPRITE_ALTO = 256

def moverse_a_izquierda(heroe, fondo)
  heroe.play flip: :horizontal

  if fondo.x < 0
    fondo.x += PASO
  elsif heroe.x > -50
    heroe.x -= PASO
  end
end

def moverse_a_derecha(heroe, fondo)
  heroe.play

  if (fondo.x - Window.width) > -IMAGEN_ANCHO
    fondo.x -= PASO
  elsif heroe.x < (Window.width - SPRITE_ANCHO)
    heroe.x += PASO
  end
end

def moverse_arriba(heroe, fondo)
  heroe.play

  if fondo.y < 0 and heroe.y > 0
    fondo.y += PASO
  elsif heroe.y > 0
    heroe.y -= PASO
  end
end

def moverse_abajo(heroe, fondo)
  heroe.play

  if (fondo.y - Window.height) > - fondo.height
    fondo.y -= PASO
  elsif heroe.y < (Window.height - SPRITE_ALTO)
    heroe.y += PASO
  end
end

def main
  fondo = Image.new(
  'fondo.png',
  y: -920
  )

  heroe = Sprite.new(
    'heroe.png',
    # heroee se separa en 4 animaciones de 256 cada una (256 x 4 = 1024, una dimension de la imagen)
    width: SPRITE_ANCHO,
    height: SPRITE_ALTO,
    clip_width: SPRITE_ANCHO,
    x: (Window.width - SPRITE_ANCHO) / 2,
    y: (Window.height - SPRITE_ALTO) / 2
  )

  mensaje = Text.new(
    "Presione cualquiera tecla para comenzar",
    x: (Window.width - 350) / 2,
    y: (Window.height - 20) / 2,
    z: 1 # Para que aparezca sobre el fondo
  )

  on :key_held do |event|
    mensaje.remove

    case event.key
    when 'left'
      moverse_a_izquierda(heroe, fondo)
    when 'right'
      moverse_a_derecha(heroe, fondo)
    when 'up'
      moverse_arriba(heroe, fondo)
    when 'down'
      moverse_abajo(heroe, fondo)
    end
  end

  on :key_up do
    heroe.stop
  end

  show
end

main
