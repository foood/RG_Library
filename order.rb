
class Order

  attr_accessor :book, :reader, :date

  def initialize(book, reader, date = Time.now)

    @book, @reader, @date  = book, reader, date
  end
end