class Api::V1::GoalsController < ApiController
  before_action :logged_in_user  
  before_action :correct_user

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: 'goal not found' }, status: :not_found
  end

  # 一覧データを返す
  def index
    render json: @user.goals
  end

  # 新規登録する
  def create
    goal = @user.goals.build(goal_params)
    if goal.save
      render json: goal, status: :created
    else
      render json: { error: "invalid params" }, status: :bad_request
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

  # 一回で複数を削除する
  def destroyMultiple
    ids = params[:ids] || []
    for id in ids do
      goal = @user.goals.find_by(id: id)
      goal.destroy unless goal.nil?
    end
    render json: @user.goals
  end

  private
    
    # form から特定のパラメータだけを取得する
    def goal_params
      params.require(:goal).permit(:content, :color, :is_finished)
    end
    
    # リクエストで指定されたゴールを返す
    def find_goal
      @user.goals.find(params[:id])
    end

    # リクエストで指定されたユーザーを返す( correct_user での判定時に呼び出される)
    def find_user
      User.find_by(id: params[:user_id])
    end
end
