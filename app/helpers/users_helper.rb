module UsersHelper

  # リクエストで指定されたユーザーがログイン中のユーザーでなければ 403 を返す
  # find_user() は各controller内で定義された find_user メソッドが呼び出される
  def correct_user
    @user = find_user
    render json: { error: "not correct user" }, status: :forbidden unless current_user?(@user)
  end
end
