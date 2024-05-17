require_relative 'equipamiento/arma'

class Jugador
  attr_reader :nombre, :pv

  def initialize(nombre, arma = Arma.new("Puños", [1, 2], Float::INFINITY, 0))
    @nombre = nombre
    @pv = 100  # Puntos de vida
    @pm = 100  # Puntos de mana
    @nivel = 1
    @arma = arma
    @exp = 0
  end

  def to_s
    if @pv <= 0
      "El jugador ha muerto. Fin de la partida."
    else
      "#{@nombre}: #{@pv}/100 PV | #{@pm}/100 PM | Nivel: #{@nivel} | EXP: #{@exp}/150\nArma equipada: #{@arma.to_s}"
    end
  end

  def saludar
    puts "Hola, soy #{@nombre} y tengo que despejar esta mazmorra."
  end

  def equipar_arma(arma)
    @arma = arma
    puts "¡Nueva arma equipada!"
  end

  def atacar(objetivo)
    if @pv <= 0
      return
    end
    if objetivo.salud <= 0
      puts "El objetivo ya esta muerto."
      return
    end

    ataque = @arma.atacar
    puts "#{@nombre} lanza un ataque contra #{objetivo.nombre}."
    pv_restante_objetivo = objetivo.recibir_ataque(ataque)

    if pv_restante_objetivo <= 0
      exp_ganada = objetivo.exp
      @exp += exp_ganada
      puts "¡#{@nombre} ha asesinado a #{objetivo.nombre}!"
      puts "¡#{@nombre} ha ganado #{exp_ganada} EXP!"
    end
  end

  def recibir_ataque(ataque_enemigo)
    @pv -= ataque_enemigo
    puts "#{@nombre} recibe #{ataque_enemigo} puntos de daño."
    if @pv <= 0
      @pv = 0
      puts "¡El jugador ha muerto en batalla! Fin de la partida."
    end
  end

  def movimiento
    puts "#{@nombre} se desplaza por la mazmorra cautelosamente."
  end

end
