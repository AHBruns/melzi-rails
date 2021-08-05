# frozen_string_literal: true

class Forms::AuthFormComponent < ViewComponent::Base
  def initialize(action:, controller:)
    @action = action
    @controller = controller
  end
end