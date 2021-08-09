# frozen_string_literal: true

class Inputs::TextFieldComponent < ViewComponent::Base
  def initialize(form:, name:, value: nil, required: false)
    @form = form
    @name = name
    @value = value
    @required = required
    @class = 'shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md'
  end
end