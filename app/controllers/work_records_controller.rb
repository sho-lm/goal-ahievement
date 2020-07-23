class WorkRecordsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  # 一覧画面を表示する
  def index
    @work_records = @user.work_records
  end

  # 登録用画面を表示する
  def new
    @work_record = WorkRecord.new
  end

  # 詳細画面を表示する
  def show
    @work_record = find_work_record
    redirect_to root_path if @work_record.nil?
  end

  # 更新用画面を表示する
  def edit
    @work_record = find_work_record
    redirect_to root_path if @work_record.nil?
  end

  # 新規登録する
  def create
    @work_record = @user.work_records.build(work_record_params)
    if @work_record.save
      redirect_to user_work_records_path(@user)
    else
      render :new
    end
  end

  # 更新する
  def update
    @work_record = find_work_record
    if @work_record.nil?
      redirect_to root_path
    elsif @work_record.update(work_record_params)
      redirect_to user_work_records_path(@user)
    else
      render "edit"
    end
  end

  # 削除する
  def destroy
    work_record = find_work_record
    if work_record.nil?
      redirect_to root_path
    else
      work_record.destroy
      redirect_to user_work_records_path(@user)
    end
  end

  private
    
    # form から特定のパラメータだけを取得する
    def work_record_params
      params.require(:work_record).permit(:content, :worked_on)
    end
    
    # リクエストで指定されたゴールを返す
    def find_work_record
      @user.work_records.find_by(id: params[:id])
    end
end
