# frozen_string_literal: true

class Buttons::V2::ButtonComponent < ViewComponent::Base
  def initialize(content_or_options: nil, options: nil)
    @content_or_options = content_or_options
    @options = options
  end
end
