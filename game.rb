require 'ruby2d'

TILE_SIZE = 40

class Game
  attr_accessor :player_x, :player_y

  def initialize(player)
    @player = player

    @mapa = [
      ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'],
      ['1', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '0', '1'],
      ['1', '0', '1', '1', '0', '1', '0', '1', '0', '1', '0', '0', '0', '0', '1'],
      ['1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1'],
      ['1', '1', '1', '0', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0', '1'],
      ['1', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '1', '0', '1'],
      ['1', '0', '0', '0', '0', '1', '1', '1', '0', '0', '1', '0', '1', '2', '1'],
      ['1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1'],
      ['1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1']
    ]
    @player_x = 1
    @player_y = 1
  end

  def draw_mapa(camera_x, camera_y)
    @mapa.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if tile == '1'
          Image.new('tiles/wall.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        elsif tile == '2'
          Image.new('tiles/rata.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        else
          Image.new('tiles/floor.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        end
      end
    end
    @player.draw((@player_x - camera_x) * TILE_SIZE, (@player_y - camera_y) * TILE_SIZE, TILE_SIZE)
  end

  def move_camera
    half_screen_tiles_x = (Window.width / TILE_SIZE / 2).floor
    half_screen_tiles_y = (Window.height / TILE_SIZE / 2).floor

    offset_x = [[@player_x - half_screen_tiles_x, 0].max, @mapa[0].size - Window.width / TILE_SIZE].min
    offset_y = [[@player_y - half_screen_tiles_y, 0].max, @mapa.size - Window.height / TILE_SIZE].min

    return offset_x, offset_y
  end

  def handle_movement(key)
    case key
    when 'left'
      if @mapa[@player_y][@player_x - 1] == '0'
        @player_x -= 1
      end
    when 'right'
      if @mapa[@player_y][@player_x + 1] == '0'
        @player_x += 1
      end
    when 'up'
      if @mapa[@player_y - 1][@player_x] == '0'
        @player_y -= 1
      end
    when 'down'
      if @mapa[@player_y + 1][@player_x] == '0'
        @player_y += 1
      end
    end
    sleep(0.02)
  end
end
