class CommentsController < ApplicationController
  def new
  end
  
  def create
    @comment = Comment.new(comment_params)
    # @comments = @prototype.comments.includes(:user)
    @comment.user_id = current_user.id
    # @comment = current_user.comment.build(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show" 
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end