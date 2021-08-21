class User < ApplicationRecord
  has_many :buyers, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many_attached :files
  
  attr_accessor :password, :new_files, :existing_files
  accepts_nested_attributes_for :buyers, :submissions, :works, :contracts, :licenses, allow_destroy: true

  before_validation :populate_salt, if: :salt.blank?
  before_validation :populate_salted_password_hash, if: :salted_password_hash.blank?

  validates_associated :buyers, :submissions, :works, :contracts, :licenses
  validates :email, :salt, :salted_password_hash, presence: true
  validates :email, uniqueness: true

  def short_description
    self.email
  end

  def check_password(password)
    self.salted_password_hash == self.generate_salted_password_hash(password)
  end

  private
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
