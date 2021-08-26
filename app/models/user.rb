class User < ApplicationRecord
  has_many :buyers, dependent: :destroy, index_errors: true
  has_many :submissions, dependent: :destroy, index_errors: true
  has_many :works, dependent: :destroy, index_errors: true
  has_many :contracts, dependent: :destroy, index_errors: true
  has_many :licenses, dependent: :destroy, index_errors: true
  has_many :email_verification_tokens, dependent: :destroy, index_errors: true
  has_many :password_reset_tokens, dependent: :destroy, index_errors: true
  has_many_attached :files
  
  attr_accessor :password, :new_files, :existing_files
  accepts_nested_attributes_for :buyers, :submissions, :works, :contracts, :licenses, allow_destroy: true

  before_validation :populate_salt, if: Proc.new { |user| user.salt.blank? }
  before_validation :populate_salted_password_hash, if: Proc.new { |user| user.salted_password_hash.blank? }

  validates_associated :buyers,
                       :submissions,
                       :works,
                       :contracts,
                       :licenses,
                       :email_verification_tokens,
                       :password_reset_tokens
  validates :email, :salt, :salted_password_hash, presence: true
  validates :email, uniqueness: true

  def short_description
    self.email
  end

  def check_password(password)
    self.salted_password_hash == self.generate_salted_password_hash(password)
  end

  def populate_salt
    self.salt = SecureRandom.hex
  end

  def populate_salted_password_hash
    self.salted_password_hash = self.generate_salted_password_hash(self.password)
  end

  def generate_salted_password_hash(password)
    Digest::SHA512.hexdigest("#{self.salt}#{password}")
  end
end
