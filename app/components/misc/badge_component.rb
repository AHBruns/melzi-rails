# frozen_string_literal: true

class Misc::BadgeComponent < ViewComponent::Base
  def initialize(color_classes: nil, key: nil)
    @color_classes = if color_classes.present?
                       color_classes[key]
                     else
                       'bg-gray-100 text-gray-800'
                     end
  end
end
