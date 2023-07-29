class Api::ApiController < ActionController::API
  include JsonWebToken

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
