class License < ApplicationRecord
  belongs_to :user
  belongs_to :work
  belongs_to :contract
  has_many_attached :files
  
  attr_accessor :new_files, :existing_files

  def short_description
    "License For #{self.work.short_description} (#{self.id})"
  end
end
