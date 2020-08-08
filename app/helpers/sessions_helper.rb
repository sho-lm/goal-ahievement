module SessionsHelper

  # ログイン済みでなければログインページにリダイレクトさせる
  def logged_in_user
    unless logged_in?
      render json: { error: "need log in" }, status: :unauthorized
    end
  end

  # 指定したユーザーをセッションに保存する
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン中のユーザーを返す(いなければnil)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  # 指定したユーザーとログイン中のユーザーが同じであればtrueを返す
  def current_user?(user)
    current_user == user
  end

  # ユーザーがログイン中ならtrueを返す
  def logged_in?
    !current_user.nil?
  end

  # セッションを破棄してログアウトする
  def log_out
    session[:user_id] = nil
    @current_user = nil
  end
end
