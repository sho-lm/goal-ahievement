class Api::V1::SessionsController < ApiController

  # ユーザーを認証できればログインする (アカウントID + パスワード)
  def create
    logger.debug(params)
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      # restfulに変更したのでサーバー側の処理はなくなった
      render json: user
    else
      render json: { error: "worng parameter for login" }, status: :bad_request
    end
  end

  # ログアウトする
  def destroy
    # restfulに変更したのでサーバー側の処理はなくなった
  end
end
