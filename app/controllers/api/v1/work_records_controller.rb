class Api::V1::WorkRecordsController < ApiController
  before_action :logged_in_user  
  before_action :correct_user

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: 'work_record not found' }, status: :not_found
  end

  # 一覧データを返す
  def index
    render json: select_where_date
  end

  # 新規登録する
  def create
    work_record = @user.work_records.build(work_record_params)
    if work_record.save
      render json: work_record, status: :created
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  # 更新する
  def update
    work_record = find
    if work_record.update(work_record_params)
      render json: work_record
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  # 削除する
  def destroy
    work_record = find
    work_record.destroy unless work_record.nil?
    render json: ""
  end

  # 一回で複数を削除する
  def destroyMultiple
    ids = params[:ids] || []
    for id in ids do
      work_record = @user.work_records.find_by(id: id)
      work_record.destroy unless work_record.nil?
    end
    render json: @user.work_records
  end

  private
    
    # form から特定のパラメータだけを取得する
    def work_record_params
      params.require(:work_record).permit(:worked_on, :worked_for, :start_time, :end_time, :memo, :goal_id)
    end
    
    # リクエストで指定されたワークレコードを返す
    def find
      @user.work_records.find(params[:id])
    end
    
    # リクエストの日付に一致するワークレコードを返す
    def select_where_date
      date = params[:date] || Date.today
      @user.work_records
        .left_joins(:goal)
        .select("work_records.*, goals.content AS goal_content")
        .where(worked_on: date)
    end

    # リクエストで指定されたユーザーを返す( correct_user での判定時に呼び出される)
    def find_user
      User.find_by(id: params[:user_id])
    end

end
