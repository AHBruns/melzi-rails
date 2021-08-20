# frozen_string_literal: true

class Forms::BuyerFieldsetComponent < ViewComponent::Base
  def initialize(form:, buyer:, current_user:, excluded_fields: Set[])
    @form = form
    @buyer = buyer
    @current_user = current_user
    @excluded_fields = excluded_fields
  end
end
