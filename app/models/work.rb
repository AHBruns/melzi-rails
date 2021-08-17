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

  def self.fields(depth = 5)
    [
      :stage,
      :title,
      *self.file_fields,
      *if depth > 0
         [
           licenses_attributes: License.fields(depth - 1),
           submissions_attributes: Submission.fields(depth - 1),
           contracts_attributes: Contract.fields(depth - 1)
         ]
       end
    ]
  end
end