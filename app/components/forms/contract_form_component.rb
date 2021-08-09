# frozen_string_literal: true

class Forms::ContractFormComponent < ViewComponent::Base
  def initialize(current_user:, contract:)
    @current_user = current_user
    @contract = contract
  end
end
