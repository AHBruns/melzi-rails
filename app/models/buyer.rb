class Buyer < ApplicationRecord
  belongs_to :user
  has_many :submissions
  has_many :contracts
  has_many_attached :files

  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :submissions, :contracts

  def short_description
    self.name
  end

  def self.fields(depth = 5)
    [
      :name,
      *self.file_fields,
      *if depth > 0
         [
           submissions_attributes: Submission.fields(depth - 1),
           contracts_attributes: Contract.fields(depth - 1)
         ]
       end
    ]
  end
end