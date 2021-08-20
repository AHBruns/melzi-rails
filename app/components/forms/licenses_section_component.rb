# frozen_string_literal: true

class Forms::LicensesSectionComponent < ViewComponent::Base
  def initialize(form:, licenses:, current_user:, excluded_fields: Set[], excluded_nested_fields: Set[])
    @form = form
    @licenses = licenses
    @current_user = current_user
    @excluded_fields = excluded_fields
    @excluded_nested_fields = excluded_nested_fields
  end
end
