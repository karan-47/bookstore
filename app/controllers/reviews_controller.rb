class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  #validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # GET /reviews or /reviews.json
  def index

    if params["id"].present?
      @reviews = Review.where('id =?', params[:id])
    elsif params[:book].present?
      @reviews = Review.joins(:book).where(books: {name: params[:book]})
    elsif params[:user].present?
      @reviews =  Review.joins(:user).where(users: {username: params[:user]})
    end
    if params["book_id"].present?
      @reviews = Review.where('book_id =?', params["book_id"])
    elsif params[:book].present?
      @reviews = Review.joins(:book).where(books: {name: params[:book]})
    elsif params[:user].present?
      @reviews = Review.joins(:user).where(users: {username: params[:user]})
    else
      @reviews = Review.where('user_id =?', current_user.id)
    end

  end



  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    if @book.nil?
      @book = Book.find(params[:book_id])
    end
  end

  # GET /reviews/1/edit
  def edit
    @book = Book.find(@review.book_id)
  end

  # POST /reviews or /reviews.json
  def create
    @book = Book.find(params[:review]["book_id"])
    @review = Review.new(review_params)

    # if @review.rating < 1 || @review.rating > 5
    #   @error_message = "Rating must be between 1 and 5"
    #   render :new
    #   return
    # end

    #@book = Book.where("id=?",params[:review]["book_id"])
    @review.user_id = current_user.id
    @review.book_id = @book.id
    # @review.id = Array.new(5){[*0..9].sample}.join
    respond_to do |format|
      if @review.save
        format.json { render :show, status: :created, location: @review }
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
        format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
        format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :review)
    end

    def book_params
      params.permit(:book_id)
    end
end
