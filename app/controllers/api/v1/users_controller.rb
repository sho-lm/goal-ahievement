class Api::V1::UsersController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    users = User.all
    render json: users
  end

  def show
    user = find_user
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      # render json: user.errors.full_messages, status: :bad_request
      render json: "", status: :bad_request
    end
  end

  def update
    user = find_user
    if user.update(user_params)
      render json: ""
    else
      render json: "", status: :bad_request
    end
  end

  def destroy
    user = find_user
    user.destroy
    log_out
    render json: ""
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
