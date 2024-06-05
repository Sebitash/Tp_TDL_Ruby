require 'ruby2d'

class Menu
  def initialize(ventana)
    @ventana = ventana
    @menu_inicial = true
    @menu = false
    @partida_iniciada = false
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
    dibujar_menu
    dibujar_textos
  end

  def dibujar_menu
    (@ventana.width / TILE_SIZE).times do |x|
      (@ventana.height / TILE_SIZE).times do |y|
        Image.new('tiles/wall.png', x: x * TILE_SIZE, y: y * TILE_SIZE, width: TILE_SIZE, height: TILE_SIZE)
      end
    end
  end

  def dibujar_textos
    @inicio_texto1 = Text.new('Tiny Dungeon', x: @ventana.width / 2 - 190, y: @ventana.height / 2 - 120, z: 1,
    style: 'bold', size: 60, color: 'brown')
    if @menu_inicial
      @inicio_texto2 = Text.new('Presione ENTER para continuar', x:@ventana.width / 2 - 180, y: @ventana.height / 2 + 10, z: 1,
      style: 'bold', size: 25, color: 'brown')
    elsif @controles
      @controles_texto1 = Text.new('Arriba [UP]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 - 30, z: 1,
      style: 'bold', size: 20, color: 'brown')
      @controles_texto2 = Text.new('Abajo [DOWN]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 0, z: 1,
      style: 'bold', size: 20, color: 'brown')
      @controles_texto3 = Text.new('Izquierda [LEFT]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 30, z: 1,
      style: 'bold', size: 20, color: 'brown')
      @controles_texto4 = Text.new('Derecha [RIGHT]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 60, z: 1,
      style: 'bold', size: 20, color: 'brown')
      @controles_texto5 = Text.new('Atacar [F]', x:@ventana.width / 2 + 40, y: @ventana.height / 2 - 30, z: 1,
      style: 'bold', size: 20, color: 'brown')
      @controles_texto6 = Text.new('Pausa [ESCAPE]', x:@ventana.width / 2 + 40, y: @ventana.height / 2 + 0, z: 1,
      style: 'bold', size: 20, color: 'brown')
      @controles_texto7 = Text.new('Volver [K]', x:@ventana.width / 2 - 220, y: @ventana.height / 2 + 120, z: 1,
      style: 'bold', size: 20, color: 'brown')
    else
      if @partida_iniciada
        @texto1 = Text.new('Continuar [Y]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 - 10, z: 1,
        style: 'bold', size: 25, color: 'brown')
      else
        @texto1 = Text.new('Iniciar [Y]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 - 10, z: 1,
        style: 'bold', size: 25, color: 'brown')
      end
      @texto2 = Text.new('Controles [K]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 20, z: 1,
      style: 'bold', size: 25, color: 'brown')
      @texto3 = Text.new('Salir [Q]', x:@ventana.width / 2 - 150, y: @ventana.height / 2 + 50, z: 1,
      style: 'bold', size: 25, color: 'brown')
    end
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
      if @controles
        @controles = false
      else
        @controles = true
      end
      sleep(0.01)
    when 'q'
      if @controles == false
        @ventana.close
      end
    end
  end

end
