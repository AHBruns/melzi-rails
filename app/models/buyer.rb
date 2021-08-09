class Buyer < ApplicationRecord
  belongs_to :user
  has_many :submissions
  has_many :contracts
  has_many_attached :files
  
  attr_accessor :new_files, :existing_files

  def short_description
    self.name
  end
end
