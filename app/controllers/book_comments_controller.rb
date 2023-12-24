class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
  end

  def destroy
    book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    if book_comment
      book_comment.destroy
    else
      flash[:alert] = "コメントが見つかりません"
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
