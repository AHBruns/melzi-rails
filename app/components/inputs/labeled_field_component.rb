# frozen_string_literal: true

class Inputs::LabeledFieldComponent < ViewComponent::Base
  def initialize(form:, key:, label:)
    @form = form
    @key = key
    @label = label
  end
end
