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
end
