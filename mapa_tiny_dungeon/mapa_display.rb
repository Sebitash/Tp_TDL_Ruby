require 'ruby2d'

set title: "Prueba Tiny Dungeon"
set width: 480
set height: 320

TILE_SIZE = 40

# mapa representado como una matriz 2D
# 1 = wall, 0 = floor
mapa = [
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
  ['1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '0', '1'],
  ['1', '0', '1', '1', '0', '1', '0', '1', '0', '1', '0', '0', '0', '0', '1'],
  ['1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1'],
  ['1', '1', '1', '0', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0', '1'],
  ['1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '1'],
  ['1', '0', '0', '0', '0', '1', '1', '1', '0', '0', '1', '0', '1', '0', '1'],
  ['1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1'],
  ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1']
]

# Posición inicial del jugador
player_x = 1
player_y = 1

# Función para dibujar el mapa
def draw_mapa(mapa, camera_x, camera_y)
    mapa.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if tile == '1'
          # Wall image
          Image.new('tiles/wall.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        else
          # Floor image
          Image.new('tiles/floor.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        end
      end
    end
  end

# Función para dibujar al jugador
def draw_player(player_x, player_y, camera_x, camera_y)
  # Player image
  Image.new('tiles/player_floor.png', x: (player_x - camera_x)*TILE_SIZE, y: (player_y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
end

# Función para mover la cámara según la posición del jugador
def move_camera(mapa, player_x, player_y)
  half_screen_tiles_x = (Window.width / TILE_SIZE / 2).floor
  half_screen_tiles_y = (Window.height / TILE_SIZE / 2).floor

  offset_x = [[player_x - half_screen_tiles_x, 0].max, mapa[0].size - Window.width / TILE_SIZE].min
  offset_y = [[player_y - half_screen_tiles_y, 0].max, mapa.size - Window.height / TILE_SIZE].min

  return offset_x, offset_y
end

update do
  clear

  # Mover la cámara y obtener su posición
  camera_x, camera_y = move_camera(mapa, player_x, player_y)

  # Dibujar el mapa y el jugador
  draw_mapa(mapa, camera_x, camera_y)
  draw_player(player_x, player_y, camera_x, camera_y)
end

on :key_held do |event|
  case event.key
  when 'left'
    if mapa[player_y][player_x - 1] == '0'
      player_x -= 1
    end
  when 'right'
    if mapa[player_y][player_x + 1] == '0'
      player_x += 1
    end
  when 'up'
    if mapa[player_y - 1][player_x] == '0'
      player_y -= 1
    end
  when 'down'
    if mapa[player_y + 1][player_x] == '0'
      player_y += 1
    end
  end
  sleep(0.07)
end

show
