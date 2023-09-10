class Admin < User
  validates :firstname, presence: true, on: :create
  validates :lastname, presence: true, on: :create
  validates :username, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates_confirmation_of :password, message: "Passwords do not match", if: -> { password.present? }
end
