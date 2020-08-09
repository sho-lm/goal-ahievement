class User < ApplicationRecord
  has_many :goals,        dependent: :destroy
  has_many :work_records, dependent: :destroy
  has_secure_password
  has_secure_token

  # attirbute ---------------------------------------------------------------------------------------------
  attribute :is_admin,   :boolean, default: false
  attribute :is_private, :boolean, default: false

  # validates ----------------------------------------------------------------------------------------------
  validates :name,  presence: true,
                          uniqueness: { case_sensitive: true },
                          length: { maximum: 20 }
  validates :password,    presence: true,
                          length: { minimum: 4, maximum: 20 },
                          allow_nil: true
  validates :is_admin,    inclusion: { in: [false, true] }
  validates :is_private,  inclusion: { in: [false, true] }

end
