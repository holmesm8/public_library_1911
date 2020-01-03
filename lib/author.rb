require './lib/book'

class Author
  attr_reader :name, :books

  def initialize(author_info)
    @name = author_info[:first_name] + " " + author_info[:last_name]
    @books = []
  end

  def write(title, date)
    new_book = Book.new({author_first_name: @name.split.first,
                        author_last_name: @name.split.last,
                        title: title,
                        publication_date: date})
    @books << new_book
    new_book
  end
end
