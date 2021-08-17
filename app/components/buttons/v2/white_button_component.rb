# frozen_string_literal: true

class Buttons::V2::WhiteButtonComponent < Buttons::V2::ButtonComponent
  def initialize(content_or_options: nil, options: {})
    @content_or_options = content_or_options
    @options = options.merge({ class: 'inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500' })
  end
end
