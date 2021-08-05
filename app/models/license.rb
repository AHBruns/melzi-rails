class License < ApplicationRecord
  belongs_to :user
  belongs_to :work
  belongs_to :contract
end
