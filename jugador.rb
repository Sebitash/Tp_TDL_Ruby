require_relative 'equipamiento/armas'

class Jugador
  attr_reader :nombre

  def initialize(nombre, arma = Punios.new)
    @nombre = nombre
    @pv = [150, 350]  # Puntos de vida
    @pm = [100, 100]  # Puntos de mana
    @oro = 0
    @nivel = 1
    @arma = arma
    @exp = [0, 150]
  end

  def dibujar(x, y, size)
    Image.new(
      'tiles/player_floor.png',
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

  def saludar
    puts "Hola, soy #{@nombre} y tengo que despejar esta mazmorra."
  end

  def equipar_arma(arma)
    @arma = arma
    puts "¡Nueva arma equipada!"
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

  def movimiento
    puts "#{@nombre} se desplaza por la mazmorra cautelosamente."
  end
end
