require_relative 'equipamiento/armas'

class Jugador
  attr_reader :nombre

  def initialize(nombre, arma = Punios.new)
    @nombre = nombre
    @pv = [15, 10]  # Puntos de vida
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

    ataque = @arma.atacar
    puts "#{@nombre} lanza un ataque contra #{objetivo.nombre}."
    pv_restante_objetivo = objetivo.recibir_ataque(ataque)

    if pv_restante_objetivo <= 0
      exp_ganada = objetivo.exp
      oro_ganado = objetivo.oro
      @exp[0] += exp_ganada
      @oro += oro_ganado
      puts "¡#{@nombre} ha asesinado a #{objetivo.nombre}!"
      puts "¡#{@nombre} ha ganado #{exp_ganada} EXP y #{oro_ganado} G!"
    end
  end

  def recibir_ataque(ataque_enemigo)
    @pv[0] -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."

    if @pv[0] <= 0
      @pv[0] = 0
      puts "¡El jugador ha muerto en batalla! Fin de la partida."
    end
  end

  def movimiento
    puts "#{@nombre} se desplaza por la mazmorra cautelosamente."
  end
end
