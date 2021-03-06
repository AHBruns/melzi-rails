# frozen_string_literal: true

class Forms::ContractsSectionComponent < ViewComponent::Base
  def initialize(
    form:,
    contracts:,
    current_user:,
    excluded_fields: Set[],
    excluded_nested_fields: Set[],
    errors: {},
    errors_key_prefix: ''
  )
    @form = form
    @contracts = contracts
    @current_user = current_user
    @excluded_fields = excluded_fields
    @excluded_nested_fields = excluded_nested_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end

end
