class Armas
  attr_reader :nombre

  def initialize(nombre, ataque, durabilidad, desgaste)
    @nombre = nombre
    @ataque = ataque  # vector de dos elementos
    @durabilidad = durabilidad
    @desgaste = desgaste
  end

  def estado
    if @durabilidad == Float::INFINITY
      "#{@nombre} | Ataque: #{@ataque[0]}-#{@ataque[1]}"
    else
      "#{@nombre} | Ataque: #{@ataque[0]}-#{@ataque[1]} | Durabilidad: #{@durabilidad} | Indice de desgaste: #{@desgaste}"
    end
  end

  def atacar
    ataque = rand(@ataque[0]..@ataque[1])

    @durabilidad -= @desgaste
    if @durabilidad <= 0
      @nombre = "Puños"
      @ataque = [1, 2]
      @durabilidad = Float::INFINITY
      @desgaste = 0
      puts "¡#{@nombre} se ha roto!"
    end

    return ataque
  end

end
