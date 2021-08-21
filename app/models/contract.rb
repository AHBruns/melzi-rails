class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :buyer
  belongs_to :submission, optional: true
  has_many :licenses, dependent: :destroy, index_errors: true
  has_many :works, through: :licenses, index_errors: true
  has_many_attached :files

  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :licenses, :works, allow_destroy: true

  validates_associated :licenses, :works
  validates :notes, :user, :buyer, :submission, presence: true

  def short_description
    "Contract With #{self.buyer.short_description} (#{self.id})"
  end

  def self.fields(current_user, depth = 5)
    [
      :id,
      :_destroy,
      :user_id,
      :notes,
      :buyer_id,
      :submission_id,
      *self.file_fields,
      *if depth > 0
         [
           licenses_attributes: License.fields(current_user, depth - 1),
           works_attributes: Work.fields(current_user, depth - 1)
         ]
       end
    ]
  end
end
