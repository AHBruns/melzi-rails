# frozen_string_literal: true

class Forms::FilesSectionsComponent < ViewComponent::Base
  def initialize(form:, files:, errors: {}, errors_key_prefix: '')
    @form = form
    @files = files
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end
end
