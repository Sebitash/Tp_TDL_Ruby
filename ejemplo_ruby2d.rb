# Ejemplo de Ruby2D para que veamos que nos anda bien
# Lo corren con:
#   ruby triangle.rb

require 'ruby2d'

set title: "Hello Triangle"

Triangle.new(
  x1: 320, y1:  50,
  x2: 540, y2: 430,
  x3: 100, y3: 430,
  color: ['red', 'green', 'blue']
)

show
