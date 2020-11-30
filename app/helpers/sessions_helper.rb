module SessionsHelper

  # ログイン済みでなければログインページにリダイレクトさせる
  def logged_in_user
    unless logged_in?
      render json: { error: "need log in" }, status: :unauthorized
    end
  end

  # リクエストで指定されたユーザーがログイン中のユーザーでなければ 403 を返す
  # find_user() は各controller内で定義された find_user メソッドが呼び出される
  def correct_user
    @user = find_user
    render json: { error: "not correct user" }, status: :forbidden unless @user.id.to_s == current_user_id
  end

  # HTTPヘッダーに設定されているユーザーIDを返す
  def current_user_id
    request.headers["HTTP_USER_ID"]
  end

  # HTTPヘッダーに設定されているユーザーの認証トークンを返す
  def current_user_token
    request.headers["HTTP_USER_TOKEN"]
  end

  # ユーザーがログイン中ならtrueを返す
  def logged_in?
    user = User.find_by(id: current_user_id, token: current_user_token)
    !user.nil?
  end

end
