require './lib/book'
require './lib/author'

class Library
  attr_reader :name, :authors, :books, :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
  end

  def add_author(author)
    @authors << author
    author.books.each {|book| @books << book}
  end

  def publication_time_frame_for(author)
    year_min = author.books.min_by {|book| book.publication_year}
    year_max = author.books.max_by {|book| book.publication_year}
    time_frame = {:start=>"#{year_min.publication_year}", :end=>"#{year_max.publication_year}"}
  end

  def checkout(book)
    if @books.include?(book) && (@checked_out_books.include?(book) == false)
      @checked_out_books << book
      book.checkout_counter += 1
      true
    else
      false
    end
  end

  def return(book)
    @checked_out_books.delete(book)
    @books << book
  end

  def most_popular_book
    sorted = @checked_out_books.sort_by do |book|
      book.checkout_counter
    end
    sorted.last
  end
end
