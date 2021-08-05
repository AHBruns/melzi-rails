# frozen_string_literal: true

class Pages::BuyersPageComponent < ViewComponent::Base
  def initialize(buyers:)
    @buyers = buyers
  end

end
