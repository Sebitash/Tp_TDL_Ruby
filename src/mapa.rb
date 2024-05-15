require 'ruby2d'

WALK_SPEED = 5

juego_empezado = false

mensaje = Text.new("Clickear para empezar", x: Window.width / 2, y: Window.height / 2)

cuadrado = nil

on :mouse_down do |event|
  if juego_empezado and mensaje.contains?(event.x, event.y)
    mensaje.remove

    cuadrado = Square.new(
      x: Window.width / 2,
      y: Window.height / 2,
      size: 25,
      color: 'purple'
    )
  else
    juego_empezado = true
  end
end

on :key_held do |event|
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


show
