class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_request, only: :create

  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments, except: %i[created_at updated_at], status: :ok
  end

  def create
    @comment = Comment.new(author_id: @current_user.id, post_id: params[:post_id], text: params[:text])

    if @comment.save
      render json: { message: 'Comment created successfully' }, status: :created
    else
      render json: { message: 'Something went wrong', errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
