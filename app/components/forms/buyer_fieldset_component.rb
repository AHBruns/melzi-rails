# frozen_string_literal: true

class Forms::BuyerFieldsetComponent < ViewComponent::Base
  def initialize(
    form:,
    buyer:,
    current_user:,
    excluded_fields: Set[],
    errors: {},
    errors_key_prefix: ''
  )
    @form = form
    @buyer = buyer
    @current_user = current_user
    @excluded_fields = excluded_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end
end
