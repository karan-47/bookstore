class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    if current_user.email == "admin@gmail.com"
      @users = User.all
    else
      @users = User.where(:email => current_user.email)
    end
    end
  # GET /users/1 or /users/1.json
  def show
    puts "Des show"
    if current_user.email !="admin@gmail.com"
      @user = User.find params[:id]
      if current_user.id != @user.id
        flash[:notice] = current_user.name+" Can't Access"
        redirect_to root_path
        return
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    puts "Des create"
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    puts "Des update"
    respond_to do |format|
      if current_user.email == "admin@ncsu.edu" or current_user.email == user_params[:email]
        if @user.update(user_params)
          format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find(params[:id])
    if (current_user.email == "admin@gmail.com") and @user.email != "admin@gmail.com"
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      if current_user.email == @user.email and @user.email != "admin@gmail.com"
        @user.destroy
        session.clear
        redirect_to signup_path, notice: "Your account has been deleted."
      else
        respond_to do |format|
          format.html { redirect_to users_url, notice: "Cannot destroy user" }
          format.json { head :no_content }
        end
    end
  end
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      puts "private des"
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      puts params
      params.require(:user).permit(:username, :password, :name, :email, :address, :creditcardnumber, :phonenumber)
    end

end
