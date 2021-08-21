class Buyer < ApplicationRecord
  belongs_to :user
  has_many :submissions, dependent: :destroy, index_errors: true
  has_many :contracts, dependent: :destroy, index_errors: true
  has_many_attached :files

  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :submissions, :contracts, allow_destroy: true

  validates_associated :submissions, :contracts
  validates :name, :user, presence: true

  def short_description
    self.name
  end

  def self.fields(current_user, depth = 5)
    [
      :id,
      :_destroy,
      :user_id,
      :name,
      *self.file_fields,
      *if depth > 0
         [
           submissions_attributes: Submission.fields(current_user, depth - 1),
           contracts_attributes: Contract.fields(current_user, depth - 1)
         ]
       end
    ]
  end
end