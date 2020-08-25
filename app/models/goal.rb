class Goal < ApplicationRecord
  belongs_to :user

  # attirbute ---------------------------------------------------------------------------------------------
  attribute :is_finished, :boolean, default: false

  # validates ----------------------------------------------------------------------------------------------
  validates :content,     presence: true,
                          length: { maximum: 20 }
  validates :color,       presence: true
  validates :is_finished, inclusion: { in: [true, false] }
  validates :user_id,     presence: true

end
