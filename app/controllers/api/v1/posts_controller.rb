class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    render json: @posts, status: :ok
  end
end