class Api::V1::UsersController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def show
    user = find_user
    render json: user
  end

  private

    # form から特定のパラメータだけを取得する
    def user_params
      params.require(:user).permit(:account_id, :name, :password)
    end

    # リクエストで指定されたユーザーを返す
    def find_user
      User.find(params[:id])
    end
    
    # リクエストで指定されたユーザーがログイン中のユーザーでなければリダイレクトする
    def correct_user
      @user = find_user
      redirect_to(root_path) unless current_user?(@user)
    end

    # ログイン中のユーザーが管理者でなければリダイレクトする
    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
