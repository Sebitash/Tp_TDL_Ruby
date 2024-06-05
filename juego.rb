require 'ruby2d'
require_relative 'creador_criaturas'

TAMAÑO_TILE = 40

class Juego
  attr_accessor :player_x, :player_y, :ventana

  def initialize(player, ventana)
    @ventana = ventana

    @player = player
    @last_attack_time = Time.now
    @numero_nivel_actual = 1
    @mapa = {
      1 => cargar_mapa("mapas_niveles/nivel1.txt"),
      2 => cargar_mapa("mapas_niveles/nivel2.txt"),
      3 => cargar_mapa("mapas_niveles/nivel3.txt"),
    }
    @mapa_nivel_actual = @mapa[@numero_nivel_actual]
    @player_x = 1
    @player_y = 1
    @game_over = false

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
    @mapa_nivel_actual.each_with_index do |row, y|
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

  def cargar_mapa(archivo)
    matriz = []

    File.foreach(archivo) do |linea|
      fila = linea.split.map(&:to_s)
      matriz << fila
    end

    matriz
  end

  def draw_mapa(camera_x, camera_y)
    @mapa_nivel_actual.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if tile == '1'
          Image.new('tiles/wall.png', x: (x - camera_x) * TAMAÑO_TILE, y: (y - camera_y) * TAMAÑO_TILE, width: TAMAÑO_TILE, height: TAMAÑO_TILE)
        else
          Image.new('tiles/floor.png', x: (x - camera_x) * TAMAÑO_TILE, y: (y - camera_y) * TAMAÑO_TILE, width: TAMAÑO_TILE, height: TAMAÑO_TILE)
        end
      end
    end
    @criaturas.each do |criatura|
      x = (criatura.x - camera_x) * TAMAÑO_TILE
      y = (criatura.y - camera_y) * TAMAÑO_TILE
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
      Image.new(imagen, x: x, y: y, width: TAMAÑO_TILE, height: TAMAÑO_TILE)
    end
    if @game_over
      Text.new('Moriste', x: @ventana.width / 2 - 90, y: @ventana.height / 2 - 50,
      style: 'bold',size: 50, color: 'red')
      Text.new('Fin del juego', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 40,
      style: 'bold',size: 50, color: 'red')
      Image.new('tiles/floor.png', x: (@player_x - camera_x) * TAMAÑO_TILE, y: (@player_y - camera_y) * TAMAÑO_TILE, width: TAMAÑO_TILE, height: TAMAÑO_TILE)
    else
      @player.dibujar((@player_x - camera_x) * TAMAÑO_TILE, (@player_y - camera_y) * TAMAÑO_TILE, TAMAÑO_TILE) if @player.pv > 0
    end
  end
  def check_criaturas_muertas
    @criaturas.reject! do |criatura|
      if criatura.pv <= 0
        @mapa_nivel_actual[criatura.y][criatura.x] = '0'
        true
      else
        false
      end
    end

    if @criaturas.empty?
      @numero_nivel_actual += 1
      @mapa_nivel_actual = @mapa[@numero_nivel_actual]
      @player_x = 1
      @player_y = 1
      crear_criaturas
    end
  end

  def check_player_alive
    if @player.pv <= 0
      @game_over = true
      @player_x = -1
      @player_y = -1
    end
  end

  def move_camera
    half_screen_tiles_x = (@ventana.width / TAMAÑO_TILE / 2).floor
    half_screen_tiles_y = (@ventana.height / TAMAÑO_TILE / 2).floor

    offset_x = [[@player_x - half_screen_tiles_x, 0].max, @mapa_nivel_actual[0].size - @ventana.width / TAMAÑO_TILE].min
    offset_y = [[@player_y - half_screen_tiles_y, 0].max, @mapa_nivel_actual[1].size - @ventana.height / TAMAÑO_TILE].min

    return offset_x, offset_y
  end

  def handle_movement(key)
    case key
    when 'left'
      if @mapa_nivel_actual[@player_y][@player_x - 1] == '0'
        @player_x -= 1
      end
    when 'right'
      if @mapa_nivel_actual[@player_y][@player_x + 1] == '0'
        @player_x += 1
      end
    when 'up'
      if @mapa_nivel_actual[@player_y - 1][@player_x] == '0'
        @player_y -= 1
      end
    when 'down'
      if @mapa_nivel_actual[@player_y + 1][@player_x] == '0'
        @player_y += 1
      end
    when 'f'
      manejo_ataque
      sleep(0.5)
    end
    sleep(0.02)
  end

  def manejo_ataque
    @criaturas.each do |criatura|
      if (criatura.x - @player_x).abs <= 1 && (criatura.y - @player_y).abs <= 1
        if criatura.x == @player_x || criatura.y == @player_y
          @player.atacar(criatura)
        end
      end
    end
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
