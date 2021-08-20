class License < ApplicationRecord
  belongs_to :user
  belongs_to :work
  belongs_to :contract
  has_many_attached :files
  
  attr_accessor :new_files, :existing_files

  def short_description
    "License For #{self.work.short_description} (#{self.id})"
  end

  def self.fields(current_user, depth = 5)
    [
      :user_id,
      :work_id,
      :contract_id,
      *self.file_fields
    ]
  end
end
