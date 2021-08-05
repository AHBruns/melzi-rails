# frozen_string_literal: true

class Pages::NewBuyerPageComponent < ViewComponent::Base
  def initialize(buyer:)
    @buyer = buyer
  end
end