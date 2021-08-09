class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :buyer
  belongs_to :work
  has_many :contracts
  enum status: [:Open, :Accepted, :Rejected]
  has_many_attached :files
  
  attr_accessor :new_files, :existing_files

  def short_description
    "#{self.work.short_description} ⇒ #{self.buyer.short_description} "
  end
end
