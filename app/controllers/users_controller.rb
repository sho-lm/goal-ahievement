class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to goals_path if @user.nil?
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find_by(id: params[:id])
    redirect_to goals_path if @user.nil?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to goals_path
    elsif @user.update(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy unless user.nil?
    redirect_to goals_path
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :password)
    end
    

end
