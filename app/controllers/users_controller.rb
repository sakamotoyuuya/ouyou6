class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def edit
      @user = User.find(params[:id])
  unless @user.id == current_user.id
   redirect_to user_path(current_user)
  end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
