class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = current_user.transactions.build
    @transaction.quantity = 0
    if @book.nil? and params[:book_id].present?
      @book = Book.find(params[:book_id])
      $bk = @book
      puts 'Found book oject and id'
      puts @book.id
    end
    @cart = Cart.all
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create

    @cart =Cart.all

    @cart.each do |cart|
      @transaction = current_user.transactions.build(transaction_params)
      @transaction.book_id = cart.book_id
      @book = Book.find(cart.book_id)
      @transaction.totalprice = @book.price*cart.quanity
      puts @transaction.totalprice
      @transaction.quantity = cart.quanity

      if @book.stock - cart.quanity >= 0
        if @transaction.save
          total_cost = @book.price * @transaction.quantity
          @transaction.update_attribute(:totalprice, total_cost)
          @book.stock = @book.stock - cart.quanity
          @book.save
          #format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
          #format.json { render :show, status: :created, location: @transaction }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      end


      Cart.delete(cart.id)
    end
    redirect_to carts_url


  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:quantity, :totalprice)
    end
end
