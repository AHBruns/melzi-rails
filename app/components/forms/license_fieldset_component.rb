# frozen_string_literal: true

class Forms::LicenseFieldsetComponent < ViewComponent::Base
  def initialize(
    form:,
    license:,
    current_user:,
    excluded_fields: Set[],
    errors: {},
    errors_key_prefix: ''
  )
    @form = form
    @license = license
    @current_user = current_user
    @excluded_fields = excluded_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end
end
