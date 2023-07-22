class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = current_user
    @like.post_id = params[:post_id]

    if @like.save
      redirect_to(request.referrer || root_path)
    else
      render :new, status: 422
    end
  end
end
