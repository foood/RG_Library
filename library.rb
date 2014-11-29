#!/usr/bin/ruby

require 'yaml'
require_relative 'book.rb'
require_relative 'order.rb'
require_relative 'reader.rb'


  class Library
    attr_accessor :books, :orders, :readers, :authors

    def initialize(file)
      @books = []

      @readers = []

      @orders = []

      load_lib(file)

      who_often_takes("Колобок")

      how_readers_three_best_books

      most_popular_book
    end

    def add_book(title, author)
       book = Book.new title, author

       @books.push book
    end

    def add_order(book_title, reader_name)
      order_book = @books.select { |book|book.title == book_title }

      order_reader = @readers.select { |reader|reader.name == reader_name }

      order = Order.new order_book, order_reader

      @orders.push order
    end

    def add_reader(name, email, city, street, house)
      reader = Reader.new name, email, city, street, house

      @readers.push reader
    end

    def load_lib(file)
      lib = File.open( file ) { |yf| YAML::load( yf ) }

      @books = lib.books

      @readers = lib.readers

      @orders = lib.orders
    end


    def save_lib(file)
      File.open(file, "w") { |file| file.puts(self.to_yaml) }
    end

    def who_often_takes(book_title)
      order_book = @books.select { |book|book.title == book_title }

      book_reader = Hash.new(0)

      @orders.select { |order|  order.book == order_book }.map { |order| book_reader[order.reader] += 1 }

      reader_max = book_reader.max_by { |k,  v| v }

      p  "Книгу: #{  book_title }, чаще всех брал:  #{ reader_max[0] }"
    end

    def all_books_orders
      all_books_orders  =  Hash.new(0)

      @orders.select  { |order|  order.book }.map  { |order|  all_books_orders[order.book] += 1 }

      all_books_orders
    end

    def most_popular_book
      book_max = all_books_orders.max_by { |k,  v| v }

      p  "Самая популярная книга:  #{ book_max[0] }"
    end

    def how_readers_three_best_books
      count_orders = 0

      best_books = all_books_orders.sort_by { |k,  v| v }

      best_books.last(3).each { |k, v| count_orders += v }

      p  "количество заказов 3-х самых популярных книг: #{ count_orders } "

    end
  end

  Library.new("library_db.yaml")
