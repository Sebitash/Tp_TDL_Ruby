require 'ruby2d'
require_relative 'creador_criaturas'
require_relative 'equipamiento/pociones'

TAMAÑO_TILE = 40
CARAC_FLOOR = '0'
CARAC_WALL = '1'
CARAC_RATA = '2'
CARAC_POC_VIDA_C = 'o'
CARAC_POC_VIDA_G = 'p'
CARAC_ARMA_ESP_BRO = 'l'
CARAC_ARMA_DAG_ACE = 'm'
CARAC_ARMA_ESP_ACE = 'n'
CARAC_ARMA_MAN_ACE = 'b'
CARAC_ARMA_MAR_GUE = 'v'
CARAC_ARMA_HAC_ACE = 'c'
CARAC_ARMA_HAC_GUE = 'x'
CARAC_ARMA_LAN_ACE = 'z'

class Juego
  attr_accessor :x_jugador, :y_jugador, :ventana

  def initialize(jugador, ventana)
    @ventana = ventana

    @jugador = jugador
    @tiempo_ultimo_ataque = Time.now
    @numero_nivel_actual = 1
    @mapa = {
      1 => cargar_mapa("mapas_niveles/nivel1.txt"),
      2 => cargar_mapa("mapas_niveles/nivel2.txt"),
      3 => cargar_mapa("mapas_niveles/nivel3.txt"),
    }
    @mapa_nivel_actual = @mapa[@numero_nivel_actual]
    @x_jugador = 1
    @y_jugador = 1
    @juego_terminado = false

    crear_criaturas
  end

  def crear_criaturas
    criatura_tipos = {
      CARAC_RATA => 'Rata',
      '3' => 'Dragon',
      '4' => 'Fenix',
      '5' => 'Grifo'
    }

    @criaturas = []

    @mapa_nivel_actual.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if criatura_tipos.key?(tile)
          tipo = criatura_tipos[tile]
          criatura = CreadorCriaturas.crear(tipo)
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

  def dibujar_mapa(x_camara, y_camara)
    @mapa_nivel_actual.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        if tile == CARAC_WALL
          imagen_tile = 'tiles/wall.png'
        elsif tile == CARAC_POC_VIDA_C
          imagen_tile = 'tiles/pocion_vida1.png'
        elsif tile == CARAC_POC_VIDA_G
          imagen_tile = 'tiles/pocion_vida2.png'
        else
          imagen_tile = 'tiles/floor.png'
        end

        Image.new(
          imagen_tile,
          x: (x - x_camara) * TAMAÑO_TILE,
          y: (y - y_camara) * TAMAÑO_TILE,
          width: TAMAÑO_TILE,
          height: TAMAÑO_TILE
        )
      end
    end

    @criaturas.each do |criatura|
      x = (criatura.x - x_camara) * TAMAÑO_TILE
      y = (criatura.y - y_camara) * TAMAÑO_TILE

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
      Image.new(
        imagen,
        x: x,
        y: y,
        width: TAMAÑO_TILE,
        height:
        TAMAÑO_TILE
      )
    end

    if @juego_terminado
      Text.new('Moriste', x: @ventana.width / 2 - 90, y: @ventana.height / 2 - 50,
      style: 'bold',size: 50, color: 'red')
      Text.new('Fin del juego', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 40,
      style: 'bold',size: 50, color: 'red')
      Image.new('tiles/floor.png', x: (@x_jugador - x_camara) * TAMAÑO_TILE, y: (@y_jugador - y_camara) * TAMAÑO_TILE, width: TAMAÑO_TILE, height: TAMAÑO_TILE)
    else
      @jugador.dibujar(
        (@x_jugador - x_camara) * TAMAÑO_TILE,
        (@y_jugador - y_camara) * TAMAÑO_TILE, TAMAÑO_TILE
      ) if @jugador.pv > 0
    end
  end

  def chequear_criaturas_muertas
    @criaturas.reject! do |criatura|
      if criatura.pv <= 0
        @mapa_nivel_actual[criatura.y][criatura.x] = CARAC_FLOOR
        true
      else
        false
      end
    end

    if @criaturas.empty?
      @numero_nivel_actual += 1
      @mapa_nivel_actual = @mapa[@numero_nivel_actual]
      @x_jugador = 1
      @y_jugador = 1
      crear_criaturas
    end
  end

  def chequear_jugador_vivo
    if @jugador.pv <= 0
      @juego_terminado = true
      @x_jugador = -1
      @y_jugador = -1
    end
  end

  def mover_camara
    half_screen_tiles_x = (@ventana.width / TAMAÑO_TILE / 2).floor
    half_screen_tiles_y = (@ventana.height / TAMAÑO_TILE / 2).floor

    offset_x = [
      [@x_jugador - half_screen_tiles_x, 0].max,
      @mapa_nivel_actual[0].size - @ventana.width / TAMAÑO_TILE
    ].min

    offset_y = [
      [@y_jugador - half_screen_tiles_y, 0].max,
      @mapa_nivel_actual[1].size - @ventana.height / TAMAÑO_TILE
    ].min

    return offset_x, offset_y
  end

  def manejar_movimiento(tecla)
    case tecla
    when 'left'
      manejo_movimiento_izquierda
    when 'right'
      manejo_movimiento_derecha
    when 'up'
      manejo_movimiento_arriba
    when 'down'
      manejo_movimiento_abajo
    when 'f'
      manejo_ataque
      sleep(0.5)
    end

    sleep(0.02)
  end

  def manejo_movimiento_izquierda
    proximo_tile = @mapa_nivel_actual[@y_jugador][@x_jugador - 1]
    if proximo_tile == CARAC_FLOOR || proximo_tile == CARAC_POC_VIDA_C || proximo_tile == CARAC_POC_VIDA_G
      if proximo_tile == CARAC_POC_VIDA_C
        if @jugador.recuperar_vida(PocionDeVidaChica.new)
          @mapa_nivel_actual[@y_jugador][@x_jugador - 1] = CARAC_FLOOR
        end
      end
      if proximo_tile == CARAC_POC_VIDA_G
        if @jugador.recuperar_vida(PocionDeVidaGrande.new)
          @mapa_nivel_actual[@y_jugador][@x_jugador - 1] = CARAC_FLOOR
        end
      end
      @x_jugador -= 1
    end
  end

  def manejo_movimiento_derecha
    proximo_tile = @mapa_nivel_actual[@y_jugador][@x_jugador + 1]
    if proximo_tile == CARAC_FLOOR || proximo_tile == CARAC_POC_VIDA_G || proximo_tile == 'k'
      if proximo_tile == CARAC_POC_VIDA_C
        if @jugador.recuperar_vida(PocionDeVidaChica.new)
          @mapa_nivel_actual[@y_jugador][@x_jugador + 1] = CARAC_FLOOR
        end
      end
      if proximo_tile == CARAC_POC_VIDA_G
        if @jugador.recuperar_vida(PocionDeVidaGrande.new)
          @mapa_nivel_actual[@y_jugador][@x_jugador + 1] = CARAC_FLOOR
        end
      end
      @x_jugador += 1
    end
  end

  def manejo_movimiento_arriba
    proximo_tile = @mapa_nivel_actual[@y_jugador - 1][@x_jugador]
    if proximo_tile == CARAC_FLOOR || proximo_tile == CARAC_POC_VIDA_C || proximo_tile == CARAC_POC_VIDA_G
      if proximo_tile == CARAC_POC_VIDA_C
        if @jugador.recuperar_vida(PocionDeVidaChica.new)
          @mapa_nivel_actual[@y_jugador - 1][@x_jugador] = CARAC_FLOOR
        end
      end
      if proximo_tile == CARAC_POC_VIDA_G
        if @jugador.recuperar_vida(PocionDeVidaGrande.new)
          @mapa_nivel_actual[@y_jugador - 1][@x_jugador] = CARAC_FLOOR
        end
      end
      @y_jugador -= 1
    end
  end

  def manejo_movimiento_abajo
    proximo_tile = @mapa_nivel_actual[@y_jugador + 1][@x_jugador]
    if proximo_tile == CARAC_FLOOR || proximo_tile == CARAC_POC_VIDA_C || proximo_tile == CARAC_POC_VIDA_G
      if proximo_tile == CARAC_POC_VIDA_C
        if @jugador.recuperar_vida(PocionDeVidaChica.new)
          @mapa_nivel_actual[@y_jugador + 1][@x_jugador] = CARAC_FLOOR
        end
      end
      if proximo_tile == CARAC_POC_VIDA_G
        if @jugador.recuperar_vida(PocionDeVidaGrande.new)
          @mapa_nivel_actual[@y_jugador + 1][@x_jugador] = CARAC_FLOOR
        end
      end
      @y_jugador += 1
    end
  end

  def manejo_ataque
    @criaturas.each do |criatura|
      if (criatura.x - @x_jugador).abs <= 1 && (criatura.y - @y_jugador).abs <= 1
        if criatura.x == @x_jugador || criatura.y == @y_jugador
          @jugador.atacar(criatura)
        end
      end
    end
  end

  def chequear_ataque_criatura
    @criaturas.each do |criatura|
      # Verificar si el jugador está vivo y si ha pasado suficiente tiempo desde el último ataque de la rata
      if @jugador.pv > 0 && (Time.now - @tiempo_ultimo_ataque >= 3) && (criatura.x - @x_jugador).abs <= 1 && (criatura.y - @y_jugador).abs <= 1
        # Verificar si el jugador y la criatura están en la misma fila o columna
        if criatura.x == @x_jugador || criatura.y == @y_jugador
          criatura.atacar(@jugador)
          puts "La vida del jugador es #{@jugador.pv}"

          @tiempo_ultimo_ataque = Time.now  # Actualizar el tiempo del último ataque
        end
      end
    end
  end
end
