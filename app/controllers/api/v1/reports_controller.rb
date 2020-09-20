class Api::V1::ReportsController < ApiController
  before_action :logged_in_user  
  before_action :correct_user

  def index_per_time
    reports_per_time = @user.work_records
                        .left_joins(:goal)
                        .select("work_records.*, goals.content AS goal_content, goals.color AS goal_color")
                        .where(worked_on: start_date..end_date)
    
    events = [];
    for r in reports_per_time
      next unless filter_checked?(r)
      event = {
        name:  r.goal_content || '設定なし',
        color: r.goal_color || '#ddd',
        start: "#{r.worked_on} #{r.start_time}",
        end:   "#{r.worked_on} #{r.end_time}",
      }
      events << event
    end
    render json: events
  end

  def index_per_date
    type = params[:type]
    reports = []
    if type == "day"
      reports = select_per_day
    elsif type == "month"
      reports = select_per_month
    end
    labels = make_labels
    datasets = make_datasets(reports, labels)
    render json: { labels: labels, datasets: datasets}
  end

  private

    # リクエストで指定されたユーザーを返す( correct_user での判定時に呼び出される)
    def find_user
      User.find_by(id: params[:user_id])
    end

    def start_date
      params[:start_date]
    end
    
    def end_date
      params[:end_date]
    end

    def filter_checked?(report)
      id = report.goal_id || "0"
      filter_list = params[:filter_list] || []
      filter_list.include?(id.to_s)
    end

    # chart のy軸のラベル
    def make_labels
      labels = []
      for date in start_date..end_date
        labels << date
      end
      labels
    end

    # label 数に合わせて0で初期化した配列を作る
    def data_template(labels)
      data_template = []
      for l in labels
        data_template << 0
      end
      data_template
    end

    # chart  のデータ
    def make_datasets(reports, labels)
      datasets = []

      prev_id = -1
      dataset = {}
      for report in reports
        next unless filter_checked?(report)

        id = report.goal_id || 0
        if id != prev_id
          dataset = {
            label:           report.content || '設定なし',
            backgroundColor: report.color   || '#bbb',
            barPercentage:   0.8,
            data:            data_template(labels)
          }
          datasets << dataset
        end
        
        # labels の日付の位置に合わせて sum(worked_for)を入れる
        work_hour = report.sum_worked_for / 60.to_f
        labels_index = labels.index(report.work_date.to_s)
        dataset[:data][labels_index] = work_hour
        prev_id = id
      end
      datasets
    end

    # 日別の集計データ
    def select_per_day
      @user.work_records
        .left_joins(:goal)
        .group(:worked_on, :goal_id)
        .select(:goal_id,
                  "goals.content",
                  "goals.color",
                  "worked_on AS work_date",
                  "sum(work_records.worked_for) AS sum_worked_for")
        .where(worked_on: start_date..end_date)
        .order("work_records.goal_id IS NULL", :goal_id, :worked_on) # Null's last in goal_id
    end

    # 月別の集計データ
    def select_per_month
      search_date = start_date + "-01"
      @user.work_records
        .left_joins(:goal)
        .group("DATE_FORMAT(work_records.worked_on, '%Y-%m')", :goal_id)
        .select(:goal_id,
          "goals.content",
          "goals.color",
          "DATE_FORMAT(work_records.worked_on, '%Y-%m') AS work_date",
          "sum(work_records.worked_for) AS sum_worked_for")
          .where(worked_on: search_date.in_time_zone.all_year)
          .order("work_records.goal_id IS NULL", :goal_id, "work_date")
    end
end
