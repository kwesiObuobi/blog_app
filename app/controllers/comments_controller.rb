class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:text))
    @comment.author = current_user
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to user_posts_url(current_user.id)
    else
      render :new, status: 422
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:comment_info])

    @comment.destroy

    respond_to do |format|
      format.html do
        redirect_to "/users/#{params[:id]}/posts", notice: 'Comment was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end
end
