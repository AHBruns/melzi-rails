# frozen_string_literal: true

class Misc::ViewMultAssociationComponent < ViewComponent::Base
  def initialize(collection:, options:, html_options: {})
    @collection = collection
    @options = options
    @html_options = html_options
  end
end
