# frozen_string_literal: true

class Forms::ContractFieldsetComponent < ViewComponent::Base
  def initialize(
    form:,
    contract:,
    current_user:,
    excluded_fields: Set[],
    errors: {},
    errors_key_prefix: '')
    @form = form
    @contract = contract
    @current_user = current_user
    @excluded_fields = excluded_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end

end
