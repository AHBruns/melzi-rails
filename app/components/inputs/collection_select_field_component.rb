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
    @class = 'shadow-sm block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md'
  end
end
