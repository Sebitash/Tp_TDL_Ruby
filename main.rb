require_relative 'dragon'
require_relative 'griffin'
require_relative 'phoenix'
require_relative 'jugador'
require_relative 'armas'
require_relative 'rata'

def ejecutar_ataque(jugador, criatura)
  if criatura.pv <= 0
    puts "El objetivo esta muerto."
    return
  end

  ataque_jugador = jugador.atacar
  ataque_criatura = criatura.atacar

  puts "#{jugador.nombre} lanza un ataque contra #{criatura.nombre}."
  puts "#{criatura.nombre} recibe #{ataque_jugador} puntos de daño."

  criatura.attack
  puts "#{jugador.nombre} recibe #{ataque_criatura} puntos de daño."

  jugador.pv -= ataque_criatura
  if jugador.pv <= 0
    jugador.pv = 0
    jugador.estado
    return
  end

  criatura.pv -= ataque_jugador
  if criatura.pv <= 0
    criatura.pv = 0
    exp_ganada = criatura.dar_exp
    jugador.exp += exp_ganada
    puts "¡#{jugador.nombre} ha asesinado a #{criatura.nombre}!"
    puts "¡#{jugador.nombre} ha ganado #{exp_ganada} EXP!"
  end
end

# Ejemplo de uso
jugador = Jugador.new("Fran")
#jugador.saludar
jugador.estado
#jugador.mover

rata = Rata.new
rata.estado

ejecutar_ataque(jugador, rata)
jugador.estado
rata.estado

nueva_arma = Armas.new("Espada de bronce", [2, 5], 150, 10)
jugador.equipar_arma(nueva_arma)
jugador.estado
ejecutar_ataque(jugador, rata)
jugador.estado
rata.estado

ejecutar_ataque(jugador, rata)
jugador.estado
rata.estado


#dragon = Dragon.new
#puts dragon.attack     # Output: ¡El Dragón ataca con fuerza! Además, escupe fuego.
#puts dragon.move       # Output: El Dragón vuela majestuosamente.

#griffin = Griffin.new
#puts griffin.attack    # Output: ¡El Grifo ataca con fuerza! Además, araña con sus garras afiladas.
#puts griffin.move      # Output: El Grifo surca los cielos con elegancia.

#phoenix = Phoenix.new
#puts phoenix.attack    # Output: ¡El Fénix ataca con fuerza! Además, golpea con sus alas ardientes.
#puts phoenix.move
