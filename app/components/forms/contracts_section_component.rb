# frozen_string_literal: true

class Forms::ContractsSectionComponent < ViewComponent::Base
  def initialize(form:, contracts:, current_user:, excluded_fields: Set[], excluded_nested_fields: Set[])
    @form = form
    @contracts = contracts
    @current_user = current_user
    @excluded_fields = excluded_fields
    @excluded_nested_fields = excluded_nested_fields
  end

end
