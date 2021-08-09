# frozen_string_literal: true

class Buttons::SecondaryButtonComponent < ViewComponent::Base
  def initialize(form: nil, url_options: nil)
    @form = form
    @url_options = url_options
    @class = 'inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500'
  end
end
