# frozen_string_literal: true

class Inputs::CollectionSelectFieldComponent < ViewComponent::Base
  def initialize(form:, object: nil, method:, collection:, value_method:, text_method:, options: {}, html_options: {})
    @form = form
    @object = object
    @method = method
    @collection = collection
    @value_method = value_method
    @text_method = text_method
    @options = options
    @html_options = html_options
  end
end
