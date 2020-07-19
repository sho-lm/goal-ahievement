class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :show, :update, :destroy]
  before_action :correct_user,   only: [:edit, :show, :update, :destroy]
  # before_action :admin_user,     only: [:index]

  # 一覧画面を表示する(管理者専用の予定)
  def index
    @users = User.all
  end

  # 登録用画面を表示する
  def new
    @user = User.new
  end
  
  # 更新用画面を表示する
  def edit
    redirect_to root_path if @user.nil?
  end

  # 詳細画面を表示する
  def show
    redirect_to root_path if @user.nil?
  end

  # 新規登録する
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
    else
      render "new"
    end
  end
  
  # 更新する
  def update
    if @user == nil
      redirect_to root_path
    elsif @user.update(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  # 削除する
  def destroy
    user = find_user
    user.destroy unless user.nil?
    redirect_to root_path
  end
  
  private

    # form から特定のパラメータだけを取得する
    def user_params
      params.require(:user).permit(:name, :password)
    end

    # リクエストで指定されたユーザーを返す
    def find_user
      User.find_by(id: params[:id])
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
