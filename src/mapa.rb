require 'ruby2d'

WALK_SPEED = 25

set width: 800
set height: 600

background = Image.new('background.png', y: -920)

juego_empezado = false
#tecla_presionada = false
cuadrado = nil

mensaje = Text.new("Clickear para empezar", x: Window.width / 2 - 90, y: Window.height / 2, z: 1)

on :mouse_down do |event|
  # Si ya existe cuadrado no añado otro mas, si ya toqué el mensaje creo cuadrado
  if juego_empezado and mensaje.contains?(event.x, event.y) and cuadrado.nil?
    mensaje.remove

    cuadrado = Square.new(
      x: 0,
      y: Window.height - 30,
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
    tecla_presionada = true
    if event.key == 'left'
      if cuadrado.x > 0
        cuadrado.x -= WALK_SPEED
      elsif background.x < 0
        background.x += WALK_SPEED
      end
    end
    if event.key == 'right'
      if cuadrado.x < (Window.width - cuadrado.size)
        cuadrado.x += WALK_SPEED
      elsif (background.x - Window.width) > -background.width
        background.x -= WALK_SPEED
      end
    end
    if event.key == 'up'
      if cuadrado.y > 0
        cuadrado.y -= WALK_SPEED
      elsif background.y < 0
        background.y += WALK_SPEED
      end
    end
    if event.key == 'down'
      if cuadrado.y < (Window.height - cuadrado.size)
        cuadrado.y += WALK_SPEED
      elsif (background.y - Window.height) > - background.height
        background.y -= WALK_SPEED
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
