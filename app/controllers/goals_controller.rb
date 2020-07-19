class GoalsController < ApplicationController
  before_action :logged_in_user  
  before_action :correct_user

  # 一覧画面を表示する
  def index
    @goals = @user.goals
  end
  
  # 登録用画面を表示する
  def new
    @goal = Goal.new
  end

  # 詳細画面を表示する
  def show
    @goal = find_goal
    redirect_to root_path if @goal.nil?
  end

  # 更新用画面を表示する
  def edit
    @goal = find_goal
    redirect_to root_path if @goal.nil?
  end
  
  # 新規登録する
  def create
    @goal = @user.goals.build(goal_params)
    if @goal.save
      redirect_to user_goals_path(@user)
    else
      render :new
    end
  end

  # 更新する
  def update
    @goal = find_goal
    if @goal.nil?
      redirect_to root_path
    elsif @goal.update(goal_params)
      redirect_to user_goals_path(@user)
    else
      render "edit"
    end
  end

  # 削除する
  def destroy
    goal = find_goal
    if goal.nil?
      redirect_to root_path
    else
      goal.destroy
      redirect_to user_goals_path(@user)
    end
  end

  private
    
    # form から特定のパラメータだけを取得する
    def goal_params
      params.require(:goal).permit(:content, :limit)
    end

    # リクエストで指定されたユーザーを返す
    def find_user
      User.find_by(id: params[:user_id])
    end
    
    # リクエストで指定されたゴールを返す
    def find_goal
      Goal.find_by(id: params[:id])
    end

    # リクエストで指定されたユーザーがログイン中のユーザーでなければリダイレクトする
    def correct_user
      @user = find_user
      redirect_to(root_path) unless current_user?(@user)
    end
end
