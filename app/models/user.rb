class User < ApplicationRecord
  has_many :buyers
  has_many :submissions
  has_many :works
  has_many :contracts
  has_many :licenses
  has_many_attached :files
  
  attr_accessor :password, :new_files, :existing_files

  validates :email, uniqueness: true

  before_create :populate_salt, if: :salt.blank?
  before_create :populate_salted_password_hash, if: :salted_password_hash.blank?

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
