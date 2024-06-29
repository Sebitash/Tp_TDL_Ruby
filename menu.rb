require 'ruby2d'

class Menu
  def initialize(ventana)
    # Ventana del juego
    @ventana = ventana
    # Menu del inicio del juego
    @menu_inicial = true
    @menu = false
    @partida_iniciada = false
    # Pantalla de controles
    @controles = false
  end
  def reiniciar_menu
    @menu_inicial = true
    @menu = false
    @partida_iniciada = false
    # Pantalla de controles
    @controles = false
  end
  def esta_abierto
    @menu_inicial || @menu || @controles
  end

  def cerrar_menu
    @menu = false
  end

  def abrir_menu
    @menu = true
    @menu_inicial = false if @partida_iniciada
    dibujar_menu
    dibujar_textos
  end

  def dibujar_menu
    (@ventana.width / TAMAÑO_TILE).times do |x|
      (@ventana.height / TAMAÑO_TILE).times do |y|
        Image.new(
          'tiles/pared.png',
          x: x * TAMAÑO_TILE,
          y: y * TAMAÑO_TILE,
          width: TAMAÑO_TILE,
          height: TAMAÑO_TILE
        )
      end
    end
  end

  def dibujar_textos
    inicio_texto1 = Text.new('Tiny Dungeon', x: @ventana.width / 2 - 190, y: @ventana.height / 2 - 120, z: 1,
    style: 'bold', size: 60, color: 'brown')
    if @menu_inicial
      dibujar_textos_menu_inicial
    elsif @controles
      dibujar_textos_controles
    else
      dibujar_textos_menu
    end
  end

  def dibujar_textos_menu_inicial
    inicio_texto2 = Text.new('Presione ENTER para continuar', x:@ventana.width / 2 - 180, y: @ventana.height / 2 + 10, z: 1,
    style: 'bold', size: 25, color: 'brown')
  end

  def dibujar_textos_menu
    if @partida_iniciada
      texto1 = Text.new('Continuar [Y]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 - 10, z: 1,
      style: 'bold', size: 25, color: 'brown')
    else
      texto1 = Text.new('Iniciar [Y]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 - 10, z: 1,
      style: 'bold', size: 25, color: 'brown')
    end
    texto2 = Text.new('Controles [K]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 20, z: 1,
    style: 'bold', size: 25, color: 'brown')
    texto3 = Text.new('Salir [Q]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 50, z: 1,
    style: 'bold', size: 25, color: 'brown')
  end

  def dibujar_textos_controles
    controles_texto1 = Text.new('Arriba [UP]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 - 30, z: 1,
    style: 'bold', size: 20, color: 'brown')
    controles_texto2 = Text.new('Abajo [DOWN]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 0, z: 1,
    style: 'bold', size: 20, color: 'brown')
    controles_texto3 = Text.new('Izquierda [LEFT]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 30, z: 1,
    style: 'bold', size: 20, color: 'brown')
    controles_texto4 = Text.new('Derecha [RIGHT]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 60, z: 1,
    style: 'bold', size: 20, color: 'brown')
    controles_texto5 = Text.new('Atacar [F]', x:@ventana.width / 2 + 40, y: @ventana.height / 2 - 30, z: 1,
    style: 'bold', size: 20, color: 'brown')
    controles_texto6 = Text.new('Pausa [ESCAPE]', x:@ventana.width / 2 + 40, y: @ventana.height / 2 + 0, z: 1,
    style: 'bold', size: 20, color: 'brown')
    controles_texto7 = Text.new('Volver [K]', x:@ventana.width / 2 - 220, y: @ventana.height / 2 + 120, z: 1,
    style: 'bold', size: 20, color: 'brown')
  end

  def gestionar_movimiento(tecla)
    case tecla
    when 'escape'
      if self.esta_abierto
        self.abrir_menu
      elsif @partida_iniciada
        self.cerrar_menu
      end
    when 'return'
      @menu_inicial = false
      self.abrir_menu
    when 'y'
      self.cerrar_menu
      @partida_iniciada = true
    when 'k'
      @controles = !@controles
      sleep(0.05)
    when 'q'
      if !@controles
        @ventana.close
      end
    end
  end

end
