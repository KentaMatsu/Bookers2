class BookCommentsController < ApplicationController

  def create
    book_comment = Book_Coment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = comment.id
    if book_comment.save
      redirect_to book_patgh(book.id)
    else
      render 'books/show'
    end
  end

  def destroy
    Book_Comment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
