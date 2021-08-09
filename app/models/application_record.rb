class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def short_description
    if self.id.present?
      self.id
    else
      self.to_s
    end
  end
end