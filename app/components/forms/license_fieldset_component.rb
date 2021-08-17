# frozen_string_literal: true

class Forms::LicenseFieldsetComponent < ViewComponent::Base
  def initialize(form:, license:, current_user:, excluded_fields: Set[])
    @form = form
    @license = license
    @current_user = current_user
    @excluded_fields = excluded_fields
  end
end
