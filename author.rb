
class Author

  attr_accessor :name, :bio

  def initialize(name = nil, bio = nil)
    @name = name if name

    @bio = bio if bio

    puts "добавлен новый автор: #{name}"
  end
end