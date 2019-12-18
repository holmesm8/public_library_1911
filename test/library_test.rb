require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'
require './lib/author'
require './lib/library'

class AuthorTest < Minitest::Test

  def setup
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  def test_testi_it_exists
    assert_instance_of Library, @dpl
  end

  def test_it_has_attributes
    assert_equal "Denver Public Library", @dpl.name
    assert_equal [], @dpl.books
    assert_equal [], @dpl.authors
  end

  def test_it_can_add_authors_and_books
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    assert_equal [@charlotte_bronte, @harper_lee], @dpl.authors
    assert_equal [@jane_eyre, @professor, @villette, @mockingbird], @dpl.books
  end

  def test_it_can_create_a_publication_timeframe
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    assert_equal ({:start=>"1847", :end=>"1857"}), @dpl.publication_time_frame_for(@charlotte_bronte)
    assert_equal ({:start=>"1960", :end=>"1960"}), @dpl.publication_time_frame_for(@harper_lee)
  end

  def test_it_can_verify_books_have_been_checked_out
    assert_equal false, @dpl.checkout(@mockingbird)
    assert_equal false, @dpl.checkout(@jane_eyre)
    assert_equal [], @dpl.checked_out_books
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    assert_equal true, @dpl.checkout(@jane_eyre)
    assert_equal true, @dpl.checkout(@villette)
    assert_equal [@jane_eyre, @villette], @dpl.checked_out_books
    @dpl.checkout(@mockingbird)
    @dpl.return(@mockingbird)
    assert_equal true, @dpl.checkout(@mockingbird)
  end
end



# Use TDD to implement the following methods on the Library class:
# The checkout method takes a Book as an argument. It should return false if a Book does not exist in the library or it is already checked out. Otherwise, it should return true indicating that the book has been checked out.
# The checked_out_books method should return an array of books that are currently checked out.
# The return method takes a Book as an argument. Calling this method means that a book is no longer checked out.
# The most_popular_book method should return the book that has been checked out the most.
# pry(main)> require './lib/library'
# #=> true
# pry(main)> require './lib/author'
# #=> true
# pry(main)> dpl = Library.new("Denver Public Library")
# #=> #<Library:0x00007f8c021685b0...>
# pry(main)> charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
# #=> #<Author:0x00007f8c01429a98...>
# pry(main)> jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
#=> #<Book:0x00007f8c01433138...>
# pry(main)> villette = charlotte_bronte.write("Villette", "1853")
# #=> #<Book:0x00007f8c021d84c8...>
# # pry(main)> harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
# #=> #<Author:0x00007f8c01442520...>
# pry(main)> mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
# #=> #<Book:0x00007f8c019506c0...>
# # This book cannot be checked out because it doesn't exist in the library
# pry(main)> dpl.checkout(mockingbird)
# #=> false
# # This book cannot be checked out because it doesn't exist in the library
# pry(main)> dpl.checkout(jane_eyre)
# #=> false
# pry(main)> dpl.add_author(charlotte_bronte)
# pry(main)> dpl.add_author(harper_lee)
# pry(main)> dpl.checkout(jane_eyre)
# #=> true
# pry(main)> dpl.checked_out_books
# => [#<Book:0x00007f8c01433138...>]
# This book cannot be checked out because it is currently checked out
# pry(main)> dpl.checkout(jane_eyre)
# #=> false
# pry(main)> dpl.return(jane_eyre)
# Returning a book means it should no longer be checked out
# pry(main)> dpl.checked_out_books
# #=> []
# pry(main)> dpl.checkout(jane_eyre)
# #=> true
# pry(main)> dpl.checkout(villette)
# #=> true
# pry(main)> dpl.checked_out_books
# #=> [#<Book:0x00007f8c01433138...>, #<Book:0x00007f8c021d84c8...>]
# pry(main)> dpl.checkout(mockingbird)
# #=> true
# pry(main)> dpl.return(mockingbird)
# pry(main)> dpl.checkout(mockingbird)
# #=> true
# pry(main)> dpl.return(mockingbird)
# pry(main)> dpl.checkout(mockingbird)
# #=> true
# pry(main)> dpl.most_popular_book
# #=> #<Book:0x00007f8c019506c0...>
