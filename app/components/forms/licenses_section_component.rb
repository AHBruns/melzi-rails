# frozen_string_literal: true

class Forms::LicensesSectionComponent < ViewComponent::Base
  def initialize(
    form:,
    licenses:,
    current_user:,
    excluded_fields: Set[],
    excluded_nested_fields: Set[],
    errors: {},
    errors_key_prefix: ''
  )
    @form = form
    @licenses = licenses
    @current_user = current_user
    @excluded_fields = excluded_fields
    @excluded_nested_fields = excluded_nested_fields
    @errors = errors
    @errors_key_prefix = errors_key_prefix
  end
end
