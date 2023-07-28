class Api::V1::CommentsController < ApplicationController
  # skip csrf
  # skip_before_action :verify_authenticity_token, only: :create

  def index
    @comments = Comment.where(post_id: params[:post_id])
    # render json: @comments, except: %i[created_at updated_at], status: :ok

    mine = User.find(10)
    passw = mine.valid_password?('1234567')
    render json: { message: passw }, status: :ok
  end

  def create
    @comment = Comment.new(author_id: 10, post_id: params[:post_id], text: params[:text])
    # @comment.new(comment_params)
    # @comment.author_id = 10
    # @comment.post_id = params[:post_id]

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
