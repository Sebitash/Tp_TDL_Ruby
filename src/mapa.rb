require 'ruby2d'

#set fps_cap: 30

PASO = 15

set width: 800
set height: 600

background = Image.new(
  'background.png',
  y: -920
)

imagen_ancho = 3072
imagen_alto = 1536

sprite_ancho = 256
sprite_alto = 256

hero = Sprite.new(
  'hero.png',
  # Heroe se separa en 4 animaciones de 256 cada una (256 x 4 = 1024, una dimension de la imagen)
  width: sprite_ancho,
  height: sprite_alto,
  clip_width: sprite_ancho,
  x: (Window.width - sprite_ancho) / 2,
  y: (Window.height - sprite_alto) / 2
)

mensaje = Text.new(
  "Presione cualquiera tecla para comenzar",
  x: (Window.width - 350) / 2,
  y: (Window.height - 20) / 2,
  z: 1 # Para que aparezca sobre el background
)

on :key_held do |event|
  mensaje.remove

  case event.key
  when 'left'
    hero.play flip: :horizontal

    if background.x < 0
      background.x += PASO
    elsif hero.x > -50
      hero.x -= PASO
    end
  when 'right'
    hero.play

    if (background.x - Window.width) > -imagen_ancho
      background.x -= PASO
    elsif hero.x < (Window.width - sprite_ancho)
      hero.x += PASO
    end
  when 'up'
    hero.play

    if background.y < 0 and hero.y > 0
      background.y += PASO
    elsif hero.y > 0
      hero.y -= PASO
    end
  when 'down'
    hero.play

    if (background.y - Window.height) > - background.height
      background.y -= PASO
    elsif hero.y < (Window.height - sprite_alto)
      hero.y += PASO
    end
  end
end

on :key_up do
  hero.stop
end

show
