require_relative 'equipamiento/armas'
require_relative 'equipamiento/pociones'

class Jugador
  attr_reader :nombre, :exp, :oro, :pv

  def initialize(nombre, arma = Punios.new)
    @nombre = nombre
    @pv = [200, 200]  # Puntos de vida
    @pm = [20, 20]  # Puntos de mana
    @oro = 0
    @nivel = 1
    @arma = arma
    @exp = [0, 50]
  end

  def dibujar(x, y, size)
    Image.new(
      'tiles/jugador.png',
      x: x,
      y: y,
      width: size,
      height: size
    )
  end

  # Muestra la información del nombre, rango de puntos de vida y de mana, nivel, rango de
  # experiencia, oro y arma equipada del jugador
  def to_s
    if @pv[0] <= 0
      "El jugador ha muerto. Fin de la partida."
    else
      "#{@nombre}:
      #{@pv[0]}/#{@pv[1]} PV |
      #{@pm[0]}/#{@pm[1]} PM |
      Nivel: #{@nivel} |
      #{@exp[0]}/#{@exp[1]} EXP |
      #{@oro} G\n
      Arma equipada: #{@arma.to_s}"
    end
  end

  def pv
    @pv[0]
  end

  def exp
    @exp[0]
  end

  def saludar
    puts "Hola, soy #{@nombre} y tengo que despejar esta mazmorra."
  end

  def equipar_arma(arma_nueva)
    arma_anterior = @arma
    @arma = arma_nueva
    puts "Nueva arma equipada: #{arma_nueva.nombre}"
    arma_anterior
  end

  def arma_equipada
    @arma.nombre
  end

  def check_subir_nivel
    if @exp[0] >= @exp[1]
      @nivel += 1
      @exp[0] = 0
      @exp[1] = @exp[1] * 2
      @pv[1] += 5
      @pm[1] += 5
      puts "¡Has subido a nivel #{@nivel}!"
    end
  end

  def atacar(objetivo)
    if @pv[0] <= 0
      return
    end

    if objetivo.pv <= 0
      puts "El objetivo ya esta muerto."
      return
    end

    daño = @arma.atacar
    puts "#{@nombre} lanza un ataque contra #{objetivo.nombre}."

    pv_restante_objetivo = objetivo.recibir_ataque(daño)

    if pv_restante_objetivo <= 0
      exp_ganada = objetivo.exp
      oro_ganado = objetivo.oro
      @exp[0] += exp_ganada
      @oro += oro_ganado
      puts "¡#{@nombre} ha asesinado a #{objetivo.nombre}!"
      puts "¡#{@nombre} ha ganado #{exp_ganada} EXP y #{oro_ganado} G!"
      check_subir_nivel
    end
  end

  def recibir_ataque(daño_ataque)
    @pv[0] -= daño_ataque
    puts "#{@nombre} recibe #{daño_ataque} puntos de daño."

    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El jugador ha muerto en batalla! Fin de la partida."
    end
  end

  def recuperar_vida(pocion_vida)
    if @pv[0] <= 0
      return false
    end
    if @pv[0] == @pv[1]
      puts "¡No necesitas usar una poción de vida!"
      return false
    end

    if @pv[0] + pocion_vida.recuperacion > @pv[1]
      @pv[0] = @pv[1]
    else
      @pv[0] += pocion_vida.recuperacion
    end

    puts "Has usado #{pocion_vida.nombre} ¡Has recuperado #{pocion_vida.recuperacion} puntos de vida!"
    return true
  end

  def movimiento
    puts "#{@nombre} se desplaza por la mazmorra cautelosamente."
  end
end
