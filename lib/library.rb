require './lib/book'
require './lib/author'

class Library
  attr_reader :name, :books, :authors, :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
  end

  def add_author(author)
    @authors << author
    @books = @authors.map { |author| author.books }.flatten
      # require "pry"; binding.pry
  end

  def publication_time_frame_for(author)
    publication_years_array = author.books.map { |book| book.publication_year }
# require "pry"; binding.pry
    earliest = publication_years_array.min
    latest = publication_years_array.max
# require "pry"; binding.pry
    timeframe = {:start => earliest, :end => latest}
  end

  def checkout(book)
    if @books.include?(book)
      @checked_out_books << @books.delete(book)
      # require "pry"; binding.pry
      true
    else
      false
    end
  end

  def return(book)
   @books << @checked_out_books.delete(book)
   require "pry"; binding.pry
 end

end
