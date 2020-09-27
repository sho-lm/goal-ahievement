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
    if duplicate_name?
      render json: { error: "duplicate_name" }, status: :bad_request
      return
    end

    user = User.new(user_params)
    if user.save
      log_in(user)
      render json: user.reload, status: :created
    else
      render json: { error: "invalid_params" }, status: :bad_request
    end
  end

  # 更新する
  def update
    if duplicate_name?
      render json: { error: "duplicate_name" }, status: :bad_request
      return
    end

    if @user.update(user_params)
      render json: @user.reload
    else
      render json: { error: "invalid_params" } , status: :bad_request
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
      params.require(:user).permit(:name, :password)
    end

    # リクエストで指定されたユーザーを返す( correct_user での判定時に呼び出される)
    def find_user
      User.find_by(id: params[:id])
    end

    # 指定された name がすでに使われているかを判断する( ture = 重複している )
    def duplicate_name?
      user = User.find_by(name: params[:user][:name])

      # 自分の name と重複していると判断するのを回避
      if @current_user && user && @current_user.id == user.id
        return false
      end

      !user.nil?
    end
end
