class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    # @books = Book.all
     puts params
    @books = Book.where(nil)
    @review = Review.all
    puts params
    if params[:book_filter].present?
      @books = Book.public_send("filter_by_#{params[:book_filter]}", params[:book_filter_value]) if params[:book_filter_value].present?
    end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    if current_user.email == "admin@gmail.com"
      @book = Book.new(book_params)

      respond_to do |format|
        if @book.save
          format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Cannot perform the action." }
        format.json { render :show, status: :ok, location: @book }
      end
    end

  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    if (current_user.email == "admin@gmail.com")
      respond_to do |format|

        if @book.update(book_params)
          format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to book_url(@book), notice: "Cannot perform the action." }
          format.json { render :show, status: :ok, location: @book }
      end
  end
    end
  # DELETE /books/1 or /books/1.json
  def destroy
    @book = Book.find(params[:id])
    if (current_user.email == "admin@gmail.com")
      @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
        format.json { head :no_content }
      end

    else
      respond_to do |format|
        format.html { redirect_to books_url, notice: "Cannot destroy book." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :author, :publisher, :price, :stock)
    end
  end
