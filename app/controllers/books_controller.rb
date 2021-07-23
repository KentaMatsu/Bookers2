class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = book.new(book_params)
    @books = Book.all
    @book.user = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = book.all
    @user = current_user
  end

  def show
    @user = @book.user
    @book = Book.new
    @book = book.find(params[:id])
  end

  def edit
    @book = book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).params(:title, :body)
    end
  

end
