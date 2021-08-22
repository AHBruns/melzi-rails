class Work < ApplicationRecord
  belongs_to :user
  has_many :submissions, dependent: :destroy, index_errors: true
  has_many :licenses, dependent: :destroy, index_errors: true
  has_many :contracts, through: :licenses, index_errors: true
  enum stage: [:Draft, :Written]
  has_many_attached :files

  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :submissions, :licenses, :contracts, allow_destroy: true

  validates_associated :submissions, :licenses
  validates :stage, :title, :user, presence: true

  def short_description
    self.title
  end

  def self.fields(current_user, depth = 5)
    [
      :id,
      :_destroy,
      :user_id,
      :stage,
      :title,
      *self.file_fields,
      *if depth > 0
         [
           licenses_attributes: License.fields(current_user, depth - 1),
           submissions_attributes: Submission.fields(current_user, depth - 1),
           contracts_attributes: Contract.fields(current_user, depth - 1)
         ]
       end
    ]
  end
end