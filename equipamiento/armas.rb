require_relative 'arma'

class Punios < Arma
  def initialize
    super("Puños", [1, 2], Float::INFINITY, 0)
  end
end

class EspadaDeBronce < Arma
  def initialize
    super("Espada de bronce", [2, 4], 150, 15)
  end
end

class DagaDeAcero < Arma
  def initialize
    super("Daga de Acero", [2, 3], 250, 12)
  end
end

class EspadaDeAcero < Arma
  def initialize
    super("Espada de Acero", [5, 10], 300, 14)
  end
end

class MandobleDeAcero < Arma
  def initialize
    super("Espada de Acero", [8, 14], 400, 15)
  end
end

class MartilloDeGuerra < Arma
  def initialize
    super("Espada de Acero", [20, 31], 500, 30)
  end
end

class HachaDeAcero < Arma
  def initialize
    super("Espada de Acero", [6, 9], 320, 12)
  end
end

class HachaDeGuerra < Arma
  def initialize
    super("Espada de Acero", [19, 27], 450, 32)
  end
end

class LanzaDeAcero < Arma
  def initialize
    super("Espada de Acero", [15, 16], 250, 10)
  end
end
