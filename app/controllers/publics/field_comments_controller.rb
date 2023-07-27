class Publics::FieldCommentsController < ApplicationController
   def create
    field = field.find(params[:field_id])
    @comment = current_customer.field_comments.new(field_comment_params)
    @comment.field_id = field.id
    @comment.save
   end

  def destroy
    @comment = FieldComment.find_by(id: params[:id], field_id: params[:field_id])
    @comment.destroy
  end

  private
  def field_comment_params
    params.require(:field_comment).permit(:comment)
  end
end


