# frozen_string_literal: true

class Inputs::FieldComponent < ViewComponent::Base
  def initialize(form:, name:, value: nil, required: false)
    @form = form
    @name = name
    @value = value
    @required = required
  end
end
