# frozen_string_literal: true

class Pages::LicensesPageComponent < ViewComponent::Base
  def initialize(licenses:)
    @licenses = licenses
  end

end
