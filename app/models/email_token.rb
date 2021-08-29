class EmailToken < ApplicationRecord
  belongs_to :user
  
  enum kind: {
    email_verification: 0,
    password_reset: 1,
  }

  validates :user, presence: true

  before_validation :fill_value, if: Proc.new { |record| record.value.blank? }
  
  def fill_value
    self.value = SecureRandom.hex(512)
  end
end
