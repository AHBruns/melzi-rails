class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :buyer
  belongs_to :work
  has_many :contracts, dependent: :destroy, index_errors: true
  enum status: [:Open, :Accepted, :Rejected]
  has_many_attached :files

  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :contracts, allow_destroy: true

  validates_associated :contracts
  validates :status, :user, :buyer, :work, presence: true

  def short_description
    "#{(self.work || Work.new).short_description} ⇒ #{(self.buyer || Buyer.new).short_description} "
  end

  def self.fields(current_user, depth = 5)
    [
      :id,
      :_destroy,
      :user_id,
      :status,
      :buyer_id,
      :work_id,
      *self.file_fields,
      *if depth > 0
         [
           contracts_attributes: Contract.fields(current_user, depth - 1)
         ]
       end
    ]
  end
end
