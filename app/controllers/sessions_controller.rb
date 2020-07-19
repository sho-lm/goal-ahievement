class SessionsController < ApplicationController
  
  # ログイン画面を表示する
  def new
  end

  # ユーザーを認証できればログインする
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      render "new"
    end
  end

  # ログアウトする
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
