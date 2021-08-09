# frozen_string_literal: true

class Forms::FilesSectionsComponent < ViewComponent::Base
  def initialize(form:, files:)
    @form = form
    @files = files
  end
end
