class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = user.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

    def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
    end
    
    
end
