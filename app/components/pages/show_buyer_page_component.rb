# frozen_string_literal: true

class Pages::ShowBuyerPageComponent < ViewComponent::Base
  def initialize(buyer:)
    @buyer = buyer
  end

end
