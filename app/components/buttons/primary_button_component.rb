# frozen_string_literal: true

class Buttons::PrimaryButtonComponent < ViewComponent::Base
  def initialize(form: nil, url_options: nil)
    @form = form
    @url_options = url_options
  end
end
