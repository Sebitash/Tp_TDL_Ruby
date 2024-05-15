require 'ruby2d'

PASO = 15

set width: 800
set height: 600

background = Image.new(
  'background.png',
  y: -920
)

juego_empezado = false

hero = Sprite.new(
  'hero.png',
  # Heroe se separa en 4 animaciones de 256 cada una (256 x 4 = 1024, una dimension de la imagen)
  width: 256,
  height: 256,
  clip_width: 256,
  x: (Window.width - 256) / 2,
  y: (Window.height - 256) / 2
)

mensaje = Text.new(
  "Presione cualquiera tecla para comenzar",
  x: Window.width / 2 - 175,
  y: Window.height / 2 - 20,
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

    if (background.x - Window.width) > -background.width
      background.x -= PASO
    elsif hero.x < 600
      hero.x += PASO
    end
  when 'up'
    hero.play

    if background.y < 0
      background.y += PASO
    elsif hero.y > 0
      hero.y -= PASO
    end
  when 'down'
    hero.play

    if (background.y - Window.height) > - background.height
      background.y -= PASO
    elsif hero.y < 350
      hero.y += PASO
    end
  end
end

on :key_up do
  hero.stop
end

show
