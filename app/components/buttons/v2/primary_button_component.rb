# frozen_string_literal: true

class Buttons::V2::PrimaryButtonComponent < Buttons::V2::ButtonComponent
  def initialize(content_or_options: nil, options: {})
    @content_or_options = content_or_options
    @options = options.merge({ class: 'inline-flex items-center justify-center w-full px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500' })
  end
end
