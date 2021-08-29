# frozen_string_literal: true

class Forms::AuthFormComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end
end