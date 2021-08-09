class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :buyer
  belongs_to :submission, optional: true
  has_many :licenses
  has_many :works, through: :licenses
  has_many_attached :files
  
  attr_accessor :new_files, :existing_files

  def short_description
    "Contract With #{self.buyer.short_description} (#{self.id})"
  end
end
