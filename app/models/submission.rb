class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :buyer
  belongs_to :work
  has_many :contracts
  enum status: [:Open, :Accepted, :Rejected]
  has_many_attached :files

  attr_accessor :new_files, :existing_files
  accepts_nested_attributes_for :contracts

  def short_description
    "#{self.work.short_description} ⇒ #{self.buyer.short_description} "
  end

  def self.fields(depth = 5)
    [
      :status,
      :buyer_id,
      :work_id,
      *self.file_fields,
      *if depth > 0
         [
           contracts_attributes: Contract.fields(depth - 1)
         ]
       end
    ]
  end
end
