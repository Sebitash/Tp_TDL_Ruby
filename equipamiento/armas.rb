require_relative 'arma'

class Punios < Arma
  def initialize
    super(
      "Puños",
      [1, 2],
      Float::INFINITY,
      0,
      'j'
    )
  end
end

class EspadaDeBronce < Arma
  def initialize
    super(
      "Espada de bronce",
      [2, 4],
      150,
      15,
      'l'
    )
  end
end

class DagaDeAcero < Arma
  def initialize
    super(
      "Daga de Acero",
      [2, 3],
      250,
      12,
      'm'
    )
  end
end

class EspadaDeAcero < Arma
  def initialize
    super(
      "Espada de Acero",
      [5, 10],
      300,
      14,
      'n'
    )
  end
end

class MandobleDeAcero < Arma
  def initialize
    super(
      "Mandoble de Acero",
      [8, 14],
      400,
      15,
      'b'
    )
  end
end

class MartilloDeGuerra < Arma
  def initialize
    super(
      "Martillo de Guerra",
      [20, 31],
      500,
      30,
      'v'
    )
  end
end

class HachaDeAcero < Arma
  def initialize
    super(
      "Hacha de Acero",
      [6, 9],
      320,
      12,
      'c'
    )
  end
end

class HachaDeGuerra < Arma
  def initialize
    super(
      "Hacha de Guerra",
      [19, 27],
      450,
      32,
      'x'
    )
  end
end

class LanzaDeAcero < Arma
  def initialize
    super(
      "Lanza de Acero",
      [15, 16],
      250,
      10,
      'z'
    )
  end
end
