module UsersHelper

  # リクエストで指定されたユーザーを返す
  def find_user
    User.find_by(id: params[:user_id])
  end

  # リクエストで指定されたユーザーがログイン中のユーザーでなければリダイレクトする
  def correct_user
    @user = find_user
    redirect_to(root_path) unless current_user?(@user)
  end
end
