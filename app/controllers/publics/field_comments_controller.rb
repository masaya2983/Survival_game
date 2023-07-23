class Publics::FieldCommentsController < ApplicationController
   def create
    field = field.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
   end

  def destroy
    @comment = FieldComment.find_by(id: params[:id], book_id: params[:book_id])
    @comment.destroy
  end

  private
  def field_comment_params
    params.require(:field_comment).permit(:comment)
  end
end


