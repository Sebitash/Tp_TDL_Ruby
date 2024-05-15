require 'ruby2d'

PASO = 15

IMAGEN_ANCHO = 3072
IMAGEN_ALTO = 1536

SPRITE_ANCHO = 256
SPRITE_ALTO = 256

class Personaje
  def initialize
    @personaje = Sprite.new(
      'personaje.png',
      # personajee se separa en 4 animaciones de 256 cada una (256 x 4 = 1024, una dimension de la imagen)
      width: SPRITE_ANCHO,
      height: SPRITE_ALTO,
      clip_width: SPRITE_ANCHO,
      x: (Window.width - SPRITE_ANCHO) / 2,
      y: (Window.height - SPRITE_ALTO) / 2
    )
  end

  def moverse_a_izquierda( fondo)
    @personaje.play flip: :horizontal

    if fondo.x < 0
      fondo.x += PASO
    elsif @personaje.x > -50
      @personaje.x -= PASO
    end
  end

  def moverse_a_derecha(fondo)
    @personaje.play

    if (fondo.x - Window.width) > -IMAGEN_ANCHO
      fondo.x -= PASO
    elsif @personaje.x < (Window.width - SPRITE_ANCHO)
      @personaje.x += PASO
    end
  end

  def moverse_arriba(fondo)
    @personaje.play

    if fondo.y < 0 and @personaje.y > 0
      fondo.y += PASO
    elsif @personaje.y > 0
      @personaje.y -= PASO
    end
  end

  def moverse_abajo(fondo)
    @personaje.play

    if (fondo.y - Window.height) > - fondo.height
      fondo.y -= PASO
    elsif @personaje.y < (Window.height - SPRITE_ALTO)
      @personaje.y += PASO
    end
  end

  def parar
    @personaje.stop
  end
end
