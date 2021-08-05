# frozen_string_literal: true

class Inputs::SelectFieldComponent < ViewComponent::Base
  def initialize(form:, object: nil, method:, choices:, options: {}, html_options: {})
    @form = form
    @object = object
    @method = method
    @choices = choices
    @options = options
    @html_options = html_options
  end
end
