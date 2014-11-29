require_relative 'author.rb'

class Book

  attr_reader :title, :author

  def initialize(title, author)

    @title =  title

    @author = author

    @author = Author.new(author, bio = nil) if author

    puts "добавлена новая книга: #{title}"
  end
end