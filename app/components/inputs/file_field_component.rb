# frozen_string_literal: true

class Inputs::FileFieldComponent < ViewComponent::Base
  def initialize(form:, object: nil, method:, options: {})
    @form = form
    @object = object
    @method = method
    @options = options
    @class = 'shadow-sm bg-white border block w-full pl-3 pr-10 py-2 text-sm border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md'
  end
end
