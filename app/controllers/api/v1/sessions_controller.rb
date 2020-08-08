class Api::V1::SessionsController < ApiController

  # ユーザーを認証できればログインする (アカウントID + パスワード)
  def create
    logger.debug(params)
    user = User.find_by(account_id: params[:account_id])
    if user && user.authenticate(params[:password])
      log_in(user)
      render json: user
    else
      render json: { error: "can't log in" }, status: :unauthorized
    end
  end

  # ログアウトする
  def destroy
    log_out if logged_in?
    render json: ""
  end
end
