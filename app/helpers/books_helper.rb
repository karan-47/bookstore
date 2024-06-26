module BooksHelper

  def get_book(book_id)
    return Book.find(book_id)
  end
  def buy_book(book_id, quantity)
    book = get_book(book_id)
    @semaphore ||= Mutex.new

    @semaphore.synchronize {
      # only one thread at a time can enter this block...
      if quantity <= book.stock
            book.stock -= quantity
            book.save
            return true
          end
    }

    return false
  end
end
