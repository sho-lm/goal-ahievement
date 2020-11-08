class Api::V1::SessionsController < ApiController

  # ユーザーを認証できればログインする (アカウントID + パスワード)
  def create
    logger.debug(params)
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      log_in(user)
      render json: user
    else
      render json: { error: "worng parameter for login" }, status: :bad_request
    end
  end

  # ログアウトする
  def destroy
    log_out if logged_in?
    render json: ""
  end
end
