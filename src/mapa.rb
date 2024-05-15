require 'ruby2d'

WALK_SPEED = 5

square = Square.new(
  x: Window.width / 2,
  y: Window.height / 2,
  size: 25,
  color: 'purple'
)

on :key_held do |event|
  if event.key == 'left'
    square.x -= WALK_SPEED
  end
  if event.key == 'right'
    square.x += WALK_SPEED
  end
  if event.key == 'up'
    square.y -= WALK_SPEED
  end
  if event.key == 'down'
    square.y += WALK_SPEED
  end
end

show
