# frozen_string_literal: true

class Inputs::FileFieldComponent < ViewComponent::Base
  def initialize(form:, object: nil, method:, options: {})
    @form = form
    @object = object
    @method = method
    @options = options
  end
end
