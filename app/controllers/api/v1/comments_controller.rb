class Api::V1::CommentsController < ApplicationController
  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments, except: %i[created_at updated_at]
  end
end
