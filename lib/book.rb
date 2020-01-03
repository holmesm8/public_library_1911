class Book
  attr_reader :title, :author, :publication_year
  attr_accessor :checkout_counter

  def initialize(book_info)
    @title = book_info[:title]
    @author = book_info[:author_first_name] + " " + book_info[:author_last_name]
    @publication_year = book_info[:publication_date][-4..-1]
    @checkout_counter = 0
  end
end
