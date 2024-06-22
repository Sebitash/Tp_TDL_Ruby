class Arma
  attr_reader :nombre, :caracter

  def initialize(nombre, rango_de_daño, durabilidad, desgaste, caracter)
    @nombre = nombre
    @rango_de_daño = rango_de_daño
    @durabilidad = durabilidad
    @desgaste = desgaste
    @caracter = caracter
  end

  # Muestra la información del nombre y rango de daño si el arma son los puños
  # O la información del nombre, rango de daño, durabilidad e indice de desgaste si es otra arma
  def to_s
    if @durabilidad == Float::INFINITY
      "#{@nombre} |
      Rango de daño: #{@rango_de_daño[0]}-#{@rango_de_daño[1]}"
    else
      "#{@nombre} |
      Rango de daño: #{@rango_de_daño[0]}-#{@rango_de_daño[1]} |
      Durabilidad: #{@durabilidad} |
      Indice de desgaste: #{@desgaste}"
    end
  end

  def atacar
    daño = rand(@rango_de_daño[0]..@rango_de_daño[1])
    @durabilidad -= @desgaste

    if @durabilidad <= 0
      @nombre = "Puños"
      @rango_de_daño = [1, 2]
      @durabilidad = Float::INFINITY
      @desgaste = 0
      puts "¡#{@nombre} se ha roto!"
    end

    return daño
  end

end
