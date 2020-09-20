class WorkRecord < ApplicationRecord
  belongs_to :user
  belongs_to :goal, optional: true

  # validates ----------------------------------------------------------------------------------------------
  validates :worked_on,   presence: true
  validates :worked_for,  numericality: { greater_than_or_equal_to: 0,
                                          less_than_or_equal_to: 1440
                                        },
                          allow_nil: true
  validates :user_id,     presence: true
end
