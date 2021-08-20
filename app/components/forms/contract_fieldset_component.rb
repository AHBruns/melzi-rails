# frozen_string_literal: true

class Forms::ContractFieldsetComponent < ViewComponent::Base
  def initialize(form:, contract:, current_user:, excluded_fields: Set[])
    @form = form
    @contract = contract
    @current_user = current_user
    @excluded_fields = excluded_fields
  end

end
