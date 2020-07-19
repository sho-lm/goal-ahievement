class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_secure_password

  # attirbute ---------------------------------------------------------------------------------------------
  attribute :is_admin,   :boolean, default: false
  attribute :is_private, :boolean, default: false

  # validates ----------------------------------------------------------------------------------------------
  validates :name,       presence: true,
                         length: { maximum: 20 },
                         uniqueness: { case_sensitive: true }
  validates :password,   presence: true,
                         length: { minimum: 6, maximum: 20 },
                         allow_nil: true
  validates :is_admin,   inclusion: { in: [false, true] }
  validates :is_private, inclusion: { in: [false, true] }

end
