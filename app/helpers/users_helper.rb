module UsersHelper

  # リクエストで指定されたユーザーを返す
  def find_user
    User.find_by(id: params[:user_id])
  end

  # リクエストで指定されたユーザーがログイン中のユーザーでなければ 401 を返す
  def correct_user
    @user = find_user
    render json: { error: "not correct user" }, status: :unauthorized unless current_user?(@user)
  end
end
