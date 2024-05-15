require 'ruby2d'

PASO = 15

set width: 800
set height: 600

background = Image.new(
  'background.png',
  y: -920
)

juego_empezado = false
#tecla_presionada = false
cuadrado = nil

mensaje = Text.new(
  "Clickear para empezar",
  x: Window.width / 2 - 90,
  y: Window.height / 2,
  z: 1 # Para que aparezca sobre el background
)

on :mouse_down do |event|
  # Si ya existe cuadrado no añado otro mas, si ya toqué el mensaje creo cuadrado
  if juego_empezado and mensaje.contains?(event.x, event.y) and cuadrado.nil?
    mensaje.remove

    cuadrado = Square.new(
      x: Window.width / 2,
      y: Window.height / 2,
      size: 25,
      color: 'purple',
      z: 1,
    )
  else
    juego_empezado = true
  end
end

on :key_held do |event|
  # Si intento moverme con el cuadrado antes de hacer click en el mensaje
  if cuadrado == nil
    puts "No se inició el juego"
    exit
  end

  #if !tecla_presionada
  #tecla_presionada = true
  if event.key == 'left'

    if background.x < 0
      background.x += PASO
    elsif cuadrado.x > 0
      cuadrado.x -= PASO
    end
  end
  if event.key == 'right'
    if (background.x - Window.width) > -background.width
      background.x -= PASO
    elsif cuadrado.x < 770
      cuadrado.x += PASO
    end
  end
  if event.key == 'up'
    if background.y < 0
      background.y += PASO
    elsif cuadrado.y > 0
      cuadrado.y -= PASO
    end
  end
  if event.key == 'down'
    if (background.y - Window.height) > - background.height
      background.y -= PASO
    elsif cuadrado.y < 570
      cuadrado.y += PASO
    end
  end
  #end
end

# Si pongo esto + lo de tecla presionada, el cuadrado se mueve como en bloque y no tan suave
/
on :key_up do
  tecla_presionada = false
end
/

show
