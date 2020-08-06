class Api::V1::UsersController < ApiController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update, :destroy]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    users = User.all
    render json: users
  end

  # ユーザーのデータを返す
  def show
    render json: @user
  end

  # 新規登録する
  def create
    user = User.new(user_params)
    if user.save
      render json: user.reload
    else
      render json: "", status: :bad_request
    end
  end

  # 更新する
  def update
    if @user.update(user_params)
      render json: @user.reload
    else
      render json: "", status: :bad_request
    end
  end

  # 削除する
  def destroy
    @user.destroy
    log_out
    render json: ""
  end

  private

    # form から特定のパラメータだけを取得する
    def user_params
      params.permit(:account_id, :name, :password)
    end

    # リクエストで指定されたユーザーを返す
    def find_user
      User.find(params[:id])
    end
    
    # ログイン中のユーザーが管理者でなければリダイレクトする
    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
