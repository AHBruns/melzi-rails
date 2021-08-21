# frozen_string_literal: true

class Forms::WorkFieldsetComponent < ViewComponent::Base
  def initialize(form:, work:, current_user:, excluded_fields: Set[], errors:, errors_key_prefix: '')
    @form = form
    @work = work
    @current_user = current_user
    @excluded_fields = excluded_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end
end
