# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end
end
