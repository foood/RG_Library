
class Reader

  attr_reader :email, :name

  def initialize(name, email, city, street, house)
    @name, @email, @city, @street, @house = name, email, city, street, house

    puts "Библиотека приветствует вас #{name}"
  end
end