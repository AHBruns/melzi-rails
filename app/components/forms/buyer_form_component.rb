# frozen_string_literal: true

class Forms::BuyerFormComponent < ViewComponent::Base
  def initialize(buyer:, current_user:)
    @buyer = buyer
    @current_user = current_user
  end
end
