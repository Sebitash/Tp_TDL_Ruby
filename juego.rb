require 'ruby2d'
require_relative 'creador_criaturas'
require_relative 'equipamiento/pociones'
require_relative 'util'
require_relative 'menu'

class Juego
  attr_accessor :x_jugador, :y_jugador, :ventana

  def initialize(jugador, ventana, menu)
    limpiar_terminal
    @ventana = ventana
    @menu = menu

    @jugador = jugador
    @tiempo_ultimo_ataque = Time.now
    @numero_nivel_actual = 1
    @mapa = {
      1 => cargar_mapa(NIVEL_1),
      2 => cargar_mapa(NIVEL_2),
      3 => cargar_mapa(NIVEL_3),
    }
    @mapa_nivel_actual = @mapa[@numero_nivel_actual]
    @x_jugador = 1
    @y_jugador = 1
    @juego_terminado = false
    @ganaste = false

    crear_criaturas
  end
  
  
  def limpiar_terminal
    system('clear') || system('cls')
  end

  def crear_criaturas
    criatura_tipos = {
      CARAC_RATA => 'Rata',
      CARAC_MURCIELAGO => 'Murcielago',
      CARAC_FANTASMA => 'Fantasma',
      CARAC_CICLOPE => 'Ciclope'
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
  
  def imprimir_arma_equipada
    Text.new("#{@jugador.arma_equipada}", x: @ventana.width / 2 - 230, y: @ventana.height / 2 + 120,
    style: 'bold', color: 'red', size: 20)
  end
  
  def dibujar_mapa(x_camara, y_camara)
    @mapa_nivel_actual.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        case tile
        when CARAC_PARED
          imagen_tile = PNG_PARED
        when CARAC_POC_VIDA_C
          imagen_tile = PNG_POC_VIDA_C
        when CARAC_POC_VIDA_G
          imagen_tile = PNG_POC_VIDA_G
        when CARAC_ARMA_ESP_BRO
          imagen_tile = PNG_ESP_BRO
        when CARAC_ARMA_DAG_ACE
          imagen_tile = PNG_DAG_ACE
        when CARAC_ARMA_ESP_ACE
          imagen_tile = PNG_ESP_ACE
        when CARAC_ARMA_MAN_ACE
          imagen_tile = PNG_MAN_ACE
        when CARAC_ARMA_MAR_GUE
          imagen_tile = PNG_MAR_GUE
        when CARAC_ARMA_HAC_ACE
          imagen_tile = PNG_HACHA_ACE
        when CARAC_ARMA_HAC_GUE
          imagen_tile = PNG_HACHA_GUE
        when CARAC_ARMA_LAN_ACE
          imagen_tile = PNG_LAN_ACE
        else
          imagen_tile = PNG_PISO
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
          PNG_RATA
        when 'Ciclope'
          PNG_CICLOPE
        when 'Murcielago'
          PNG_MURCIELAGO
        when 'Fantasma'
          PNG_FANTASMA
        end
      Image.new(
        imagen,
        x: x,
        y: y,
        width: TAMAÑO_TILE,
        height: TAMAÑO_TILE
      )
    end
  
    if @juego_terminado
      if @ganaste
        sleep(5)
        @ventana.close if @ventana
      else
        Text.new('Moriste', x: @ventana.width / 2 - 90, y: @ventana.height / 2 - 50,
                 style: 'bold', size: 50, color: 'red')
        Text.new('Fin del juego', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 40,
                 style: 'bold', size: 50, color: 'red')
      end
      Image.new(PNG_PISO, x: (@x_jugador - x_camara) * TAMAÑO_TILE, y: (@y_jugador - y_camara) * TAMAÑO_TILE, width: TAMAÑO_TILE, height: TAMAÑO_TILE)
    else
      imprimir_arma_equipada
      @jugador.dibujar(
        (@x_jugador - x_camara) * TAMAÑO_TILE,
        (@y_jugador - y_camara) * TAMAÑO_TILE, TAMAÑO_TILE
      ) if @jugador.pv > 0
    end
  end
  

  def chequear_criaturas_muertas
    @criaturas.reject! do |criatura|
      if criatura.pv <= 0
        @mapa_nivel_actual[criatura.y][criatura.x] = CARAC_PISO
        true
      else
        false
      end
    end
  
    if @criaturas.empty?
      if @numero_nivel_actual < @mapa.keys.max
        @numero_nivel_actual += 1
        @mapa_nivel_actual = @mapa[@numero_nivel_actual]
        @x_jugador = 1
        @y_jugador = 1
        crear_criaturas
      else
        @juego_terminado = true
        @ganaste = true
        mostrar_mensaje_ganaste
        
      end
    end
  end
  
  def mostrar_mensaje_ganaste
    limpiar_terminal
    Rectangle.new(
      x: 0, y: 0,
      width: @ventana.width, height: @ventana.height,
      color: 'black'
    )
    Text.new(
      '¡Ganaste el juego!',
      x: @ventana.width / 2 - 230,
      y: @ventana.height / 2 - 50,
      style: 'bold',
      size: 50,
      color: 'green'
    )
    Text.new(
      'Gracias por jugar',
      x: @ventana.width / 2 - 100,
      y: @ventana.height / 2 + 80,
      style: 'bold',
      size: 25,
      color: 'red'
    )
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
      manejar_proximo_tile(-1, 0)
    when 'right'
      manejar_proximo_tile(1, 0)
    when 'up'
      manejar_proximo_tile(0, -1)
    when 'down'
      manejar_proximo_tile(0, 1)
    when 'f'
      manejo_ataque
      sleep(0.5)
    end
    sleep(0.02)
  end

  def movimiento_criaturas
    @criaturas.each do |criatura|
      posicion_anterior_x = criatura.x
      posicion_anterior_y = criatura.y
  
      criatura.movimiento(@mapa_nivel_actual, @criaturas, @x_jugador, @y_jugador)
  
      if criatura.x != posicion_anterior_x || criatura.y != posicion_anterior_y
        @mapa_nivel_actual[posicion_anterior_y][posicion_anterior_x] = CARAC_PISO
      end
    end
  end
  

  def manejar_proximo_tile(movimiento_x, movimiento_y)
    proximo_x = @x_jugador + movimiento_x
    proximo_y = @y_jugador + movimiento_y
    proximo_tile = @mapa_nivel_actual[proximo_y][proximo_x]
    proximo_tile = @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x]
    return if @criaturas.any? { |criatura| criatura.x == proximo_x && criatura.y == proximo_y }

    if OBJETOS_ATRAVESABLES.include?(proximo_tile)
      case proximo_tile
      when CARAC_POC_VIDA_C
        if @jugador.recuperar_vida(PocionDeVidaChica.new)
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_POC_VIDA_G
        if @jugador.recuperar_vida(PocionDeVidaGrande.new)
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_DAG_ACE
        arma_anterior = @jugador.equipar_arma(DagaDeAcero.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_ESP_BRO
        arma_anterior = @jugador.equipar_arma(EspadaDeBronce.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_ESP_ACE
        arma_anterior = @jugador.equipar_arma(EspadaDeAcero.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_MAN_ACE
        arma_anterior = @jugador.equipar_arma(MandobleDeAcero.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_MAR_GUE
        arma_anterior = @jugador.equipar_arma(MartilloDeGuerra.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_HAC_ACE
        arma_anterior = @jugador.equipar_arma(HachaDeAcero.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_HAC_GUE
        arma_anterior = @jugador.equipar_arma(HachaDeGuerra.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      when CARAC_ARMA_LAN_ACE
        arma_anterior = @jugador.equipar_arma(LanzaDeAcero.new)
        if arma_anterior.caracter != CARAC_PUNIOS
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = arma_anterior.caracter
        else
          @mapa_nivel_actual[@y_jugador + movimiento_y][@x_jugador + movimiento_x] = CARAC_PISO
        end
      end
      @x_jugador += movimiento_x
      @y_jugador += movimiento_y
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
      if @jugador.pv > 0 && (Time.now - @tiempo_ultimo_ataque >= 3) && (criatura.x - @x_jugador).abs <= 1 && (criatura.y - @y_jugador).abs <= 1
        if criatura.x == @x_jugador || criatura.y == @y_jugador
          criatura.atacar(@jugador)
          puts "La vida del jugador es #{@jugador.pv}"

          @tiempo_ultimo_ataque = Time.now  
        end
      end
    end
  end

  def mostrar_caracteristicas_personaje
    texto_exp = Text.new(
      "EXP: #{@jugador.exp}",
      y: 5,
      style: 'bold',
      size: 20,
      color: 'green',
      z: 2
    )

    texto_oro = Text.new(
      "ORO: #{@jugador.oro}",
      x: 100,
      y: 5,
      style: 'bold',
      size: 20,
      color: 'yellow',
      z: 2
    )

    texto_pv = Text.new(
      "PV: #{@jugador.pv}",
      x: 200,
      y: 5,
      style: 'bold',
      size: 20,
      color: 'red',
      z: 2
    )
  end
end
