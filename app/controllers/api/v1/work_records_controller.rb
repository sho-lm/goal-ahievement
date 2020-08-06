class Api::V1::WorkRecordsController < ApiController
  before_action :logged_in_user  
  before_action :correct_user

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  # 一覧データを返す
  def index
    render json: @user.work_records
  end

  # 新規登録する
  def create
    work_record = @user.work_records.build(work_record_params)
    if work_record.save
      render json: work_record
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  # 更新する
  def update
    work_record = find_work_record
    if work_record.update(work_record_params)
      render json: work_record
    else
      render json: { error: "invalid params" }, status: :bad_request
    end
  end

  # 削除する
  def destroy
    work_record = find_work_record
    work_record.destroy unless work_record.nil?
    render json: ""
  end

  private
    
    # form から特定のパラメータだけを取得する
    def work_record_params
      params.permit(:content, :worked_on)
    end
    
    # リクエストで指定されたゴールを返す
    def find_work_record
      @user.work_records.find(params[:id])
    end
end
