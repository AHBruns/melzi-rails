# frozen_string_literal: true

class Pages::EditBuyerPageComponent < ViewComponent::Base
  def initialize(buyer:)
    @buyer = buyer
  end

end
