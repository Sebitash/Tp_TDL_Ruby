require 'ruby2d'

WALK_SPEED = 20

background = Image.new(
  'basic.png',
  width: Window.width,
  height: Window.height,
  z: 0
)

juego_empezado = false
tecla_presionada = false
cuadrado = nil

mensaje = Text.new("Clickear para empezar", x: Window.width / 2 - 90, y: Window.height / 2, z: 1)

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

  if !tecla_presionada
    tecla_presionada = true
    if event.key == 'left'
      cuadrado.x -= WALK_SPEED
    end
    if event.key == 'right'
      cuadrado.x += WALK_SPEED
    end
    if event.key == 'up'
      cuadrado.y -= WALK_SPEED
    end
    if event.key == 'down'
      cuadrado.y += WALK_SPEED
    end
  end
end

# Esto hace que se mueva como de bloque en bloque y no tan suave
on :key_up do
  tecla_presionada = false
end

show
