require_relative 'pocion'

class PocionDeVidaChica < Pocion
  def initialize
    super(
      "Poción de vida chica",
      15
    )
  end

  def to_s
    "#{@nombre} | Recupera #{@recuperacion} puntos de vida"
  end

  def usar(jugador)
    jugador.recuperar_vida(self)
  end
end

class PocionDeVidaGrande < Pocion
  def initialize
    super(
      "Poción de vida grande",
      50
    )
  end

  def to_s
    "#{@nombre} | Recupera #{@recuperacion} puntos de vida"
  end

  def usar(jugador)
    jugador.recuperar_vida(self)
  end
end
