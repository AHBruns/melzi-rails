class EmailVerificationToken < ApplicationRecord
  belongs_to :user

  validates :token, :user, presence: true
end
