class Api::V1::GoalsController < ApiController
  before_action :logged_in_user  
  before_action :correct_user

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  # 一覧データを返す
  def index
    goals = Goal.all
    render json: goals
  end

  # 新規登録する
  def create
    goal = @current_user.goals.build(goal_params)
    if goal.save
      render json: goal
    else
      render json: { error: "bad request" }, status: :bad_request
    end
  end

  # 更新する
  def update
    goal = find_goal
    if goal.update(goal_params)
      render json: goal
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  # 削除する
  def destroy
    goal = find_goal
    goal.destroy unless goal.nil?
    render json: ""
  end

  private
    
    # form から特定のパラメータだけを取得する
    def goal_params
      params.require(:goal).permit(:content, :limit)
    end
    
    # リクエストで指定されたゴールを返す
    def find_goal
      @current_user.goals.find(params[:id])
    end

end
