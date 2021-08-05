# frozen_string_literal: true

class Inputs::CheckBoxFieldComponent < ViewComponent::Base
  def initialize(form:, object: nil, method:, options: {}, checked_value: "1", unchecked_value: "0")
    @form = form
    @object = object
    @method = method
    @options = options
    @checked_value = checked_value
    @unchecked_value = unchecked_value
  end
end
