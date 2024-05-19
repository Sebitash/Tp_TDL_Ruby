require_relative 'arma'

class Punios < Arma
  def initialize
    super("Puños", [1, 2], Float::INFINITY, 0)
  end
end

class EspadaDeBronce < Arma
  def initialize
    super("Espada de bronce", [2, 5], 150, 10)
  end
end
