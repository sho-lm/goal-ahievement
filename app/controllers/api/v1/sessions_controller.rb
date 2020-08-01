class Api::V1::SessionsController < ApplicationController
  # CSRFトークン認証をしない
  skip_before_action :verify_authenticity_token

  # ユーザーを認証できればログインする
  def create
    user = User.find_by(account_id: params[:session][:account_id])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      render json: user
    else
      render json: "", status: :unauthorized
    end
  end

  # ログアウトする
  def destroy
    log_out if logged_in?
    render json: ""
  end
end
