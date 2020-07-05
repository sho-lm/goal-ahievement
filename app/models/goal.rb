class Goal < ApplicationRecord
  attribute :achievement_flag,      :boolean, default: false
  attribute :progress,              :integer, default: 0
  attribute :hierarchy,             :integer, default: 1
  attribute :children_length,       :integer, default: 0
  attribute :parent_id,             :integer, default: 1
  attribute :user_id,               :integer, default: 1

  validates :content,                   presence: true
  # validates :limit,                   
  validates :achievement_flag,          inclusion: { in: [true, false] }
  validates :progress,                  presence: true,
                                        numericality: { greater_than_or_equal_to: 0,
                                                        less_than_or_equal_to: 100
                                                      }
  # validates :order_number, 
  validates :hierarchy,                 presence: true,
                                        inclusion: { in: 1..3 }
  validates :children_length,           presence: true
  validates :parent_id,                 presence: true
  validates :user_id,                   presence: true


  def progress_rate
    "#{progress}%"
  end
end
