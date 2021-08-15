class Work < ApplicationRecord
  belongs_to :user
  has_many :submissions
  has_many :licenses
  has_many :contracts, through: :licenses
  enum stage: [:Draft, :Written]
  has_many_attached :files
  
  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :submissions, :licenses, :contracts

  def short_description
    self.title
  end
end