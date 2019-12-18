require './lib/book'
require './lib/author'

class Library
  attr_reader :name, :books, :authors

  def initialize(name)
    @name = name
    @books = []
    @authors = []
  end

  def add_author(author)
    @authors << author
    @books = @authors.map { |author| author.books }.flatten
      # require "pry"; binding.pry
  end

  def publication_time_frame_for(author)
    years = author.books.map { |book| book.publication_year }
# require "pry"; binding.pry
    earliest = years.min
    latest = years.max
# require "pry"; binding.pry
    testy = {:start => earliest, :end => latest}
  end
end
