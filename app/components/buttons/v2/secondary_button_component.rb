# frozen_string_literal: true

class Buttons::V2::SecondaryButtonComponent < Buttons::V2::ButtonComponent
  def initialize(content_or_options: nil, options: {})
    @content_or_options = content_or_options
    @options = options.merge({ class: 'inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500' })
  end
end
