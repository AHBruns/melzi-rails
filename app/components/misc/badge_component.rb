# frozen_string_literal: true

class Misc::BadgeComponent < ViewComponent::Base
  
  def initialize(color_classes: nil, key: nil)
    if (color_classes.present?)
      @color_classes = color_classes[key]
      p @color_classes
    else
      @color_classes = "bg-gray-100 text-gray-800"
    end
  end
end
