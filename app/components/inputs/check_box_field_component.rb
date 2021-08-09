# frozen_string_literal: true

class Inputs::CheckBoxFieldComponent < ViewComponent::Base
  def initialize(form:, object: nil, method:, options: {}, checked_value: "1", unchecked_value: "0")
    @form = form
    @object = object
    @method = method
    @options = options
    @checked_value = checked_value
    @unchecked_value = unchecked_value
    @class = 'focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded'
  end
end
