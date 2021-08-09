# frozen_string_literal: true

class Misc::StyledLinkToComponent < ViewComponent::Base
  def initialize(name:, options:, html_options: {})
    @name = name
    @options = options
    @html_options = html_options
    @class = 'text-indigo-600 rounded-md hover:text-indigo-900 focus:outline-none focus:underline'
  end
end
