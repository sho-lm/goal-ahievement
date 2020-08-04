class Api::V1::AuthenticationsController < ApiController
  # CSRFトークン認証をしない
  # skip_before_action :verify_authenticity_token


  # ユーザーを認証できればログインする (ID + トークン)
  def create
    user = User.find_by(id: params[:id], token: params[:token])
    if user
      log_in(user)
      render json: user
    else
      render json: { error: "can't authenticate" }, status: :unauthorized
    end
  end
end
