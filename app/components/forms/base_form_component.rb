# frozen_string_literal: true

class Forms::BaseFormComponent < ViewComponent::Base
  def initialize(form:, errors:)
    @form = form
    @errors = errors
  end
end
