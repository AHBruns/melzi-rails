# frozen_string_literal: true

class Forms::ResetPasswordFormComponent < ViewComponent::Base
  def initialize(token:)
    @token = token
  end
end
