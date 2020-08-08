class Api::V1::UsersController < ApiController
  before_action :logged_in_user, only: [:update, :destroy]
  before_action :correct_user,   only: [:update, :destroy]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    users = User.all
    render json: users
  end

  # 新規登録する
  def create
    user = User.new(user_params)
    if user.save
      log_in(user)
      render json: user.reload, status: :created
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  # 更新する
  def update
    if @user.update(user_params)
      render json: @user.reload
    else
      render json: { error: "invalid params" } , status: :bad_request
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
      params.require(:user).permit(:account_id, :name, :password)
    end

    # リクエストで指定されたユーザーを返す( correct_user での判定時に呼び出される)
    def find_user
      User.find_by(id: params[:id])
    end
end
