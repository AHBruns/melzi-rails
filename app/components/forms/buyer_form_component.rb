# frozen_string_literal: true

class Forms::BuyerFormComponent < ViewComponent::Base
  def initialize(buyer:)
    @buyer = buyer
  end
end
