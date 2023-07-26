class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author = current_user

    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_to '/'
    else
      render :new, status: 422
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    @post.likes.destroy_all
    @post.comments.destroy_all

    @post.destroy

    respond_to do |format|
      format.html { redirect_to "/users/#{params[:user_id]}/posts", notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
