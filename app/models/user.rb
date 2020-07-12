class User < ApplicationRecord
  attribute :is_admin,   :boolean, default: false
  attribute :is_private, :boolean, default: false

  validates :name,       presence: true,
                         length: { maximum: 50 }
  validates :password,   presence: true,
                         length: { minimum: 6, maximum: 20   }
  validates :is_admin,   inclusion: { in: [false, true] }
  validates :is_private, inclusion: { in: [false, true] }

  has_secure_password
end
