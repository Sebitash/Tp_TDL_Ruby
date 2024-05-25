require 'ruby2d'
require_relative 'creador_criaturas'

TILE_SIZE = 40

class Game
  attr_accessor :player_x, :player_y

  def initialize(player)
    @player = player
    @last_attack_time = Time.now
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
    crear_criaturas
  end

  def crear_criaturas
    criatura_tipos = {
      '2' => 'Rata',
      '3' => 'Dragon',
      '4' => 'Fenix',
      '5' => 'Grifo'
    }
    @criaturas = []
    @mapa.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if criatura_tipos.key?(tile)
          tipo = criatura_tipos[tile]
          criatura = CriaturaFactory.crear(tipo)
          criatura.x = x
          criatura.y = y
          @criaturas << criatura
        end
      end
    end
  end

  def draw_mapa(camera_x, camera_y)
    @mapa.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if tile == '1'
          Image.new('tiles/wall.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        else
          Image.new('tiles/floor.png', x: (x - camera_x) * TILE_SIZE, y: (y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
        end
      end
    end
    @criaturas.each do |criatura|
      x = (criatura.x - camera_x) * TILE_SIZE
      y = (criatura.y - camera_y) * TILE_SIZE
      imagen = case criatura.nombre
               when 'Rata'
                 'tiles/rata.png'
               when 'Dragon'
                 'tiles/dragon.png'
               when 'Fenix'
                 'tiles/fenix.png'
               when 'Grifo'
                 'tiles/grifo.png'
               end
      Image.new(imagen, x: x, y: y, width: TILE_SIZE, height: TILE_SIZE)
    end
    if @player.pv > 0
      @player.draw((@player_x - camera_x) * TILE_SIZE, (@player_y - camera_y) * TILE_SIZE, TILE_SIZE)
    else
      Image.new('tiles/floor.png', x: (@player_x - camera_x) * TILE_SIZE, y: (@player_y - camera_y) * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
    end
  end
  def check_player_alive
    # Verificar si el jugador está muerto y eliminarlo de la lista de criaturas si es así
    if @player.pv <= 0
      @player_x = -1  # Mover al jugador fuera del mapa
      @player_y = -1
    end
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
  def check_criatura_attacks
    @criaturas.each do |criatura|
      # Verificar si el jugador está vivo y ha pasado suficiente tiempo desde el último ataque de la rata
      if @player.pv > 0 && (Time.now - @last_attack_time >= 3) && (criatura.x - @player_x).abs <= 1 && (criatura.y - @player_y).abs <= 1
        # Verificar si el jugador y la criatura están en la misma fila o columna
        if criatura.x == @player_x || criatura.y == @player_y
          criatura.atacar(@player)
          puts "La vida del jugador es #{@player.pv}" 

          @last_attack_time = Time.now  # Actualizar el tiempo del último ataque
        end
      end
    end

  end
end
