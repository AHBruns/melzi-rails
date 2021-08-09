# frozen_string_literal: true

class Misc::ViewAssociationComponent < ViewComponent::Base
  def initialize(object:, html_options: {})
    @object = object
    @html_options = html_options
  end
end
