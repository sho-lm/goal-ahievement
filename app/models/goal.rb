class Goal < ApplicationRecord
  belongs_to :user

  # attirbute ---------------------------------------------------------------------------------------------
  attribute :achievement_flag,      :boolean, default: false
  attribute :progress,              :integer, default: 0
  attribute :hierarchy,             :integer, default: 1
  attribute :children_length,       :integer, default: 0

  # validates ----------------------------------------------------------------------------------------------
  validates :content,                   presence: true
  validates :achievement_flag,          inclusion: { in: [true, false] }
  validates :progress,                  presence: true,
                                        numericality: { greater_than_or_equal_to: 0,
                                                        less_than_or_equal_to: 100
                                                      }
  validates :hierarchy,                 presence: true,
                                        inclusion: { in: 1..3 }
  validates :children_length,           presence: true
  validates :user_id,                   presence: true

  # methods -------------------------------------------------------------------------------------------------

  # 進捗率を%の単位つきで返す( progress = 80 のときは 80% を返す)
  def progress_rate
    "#{progress}%"
  end
end
