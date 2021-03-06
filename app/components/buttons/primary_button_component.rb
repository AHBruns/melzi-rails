# frozen_string_literal: true

class Buttons::PrimaryButtonComponent < ViewComponent::Base
  def initialize(form: nil, url_options: nil)
    @form = form
    @url_options = url_options
    @class = 'inline-flex items-center justify-center w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500'
  end
end
