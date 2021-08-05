# frozen_string_literal: true

class Misc::StyledLinkToComponent < ViewComponent::Base
  def initialize(name:, options:, html_options: {})
    @name = name
    @options = options
    @html_options = html_options
  end
end
